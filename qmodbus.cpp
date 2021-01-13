#include "qmodbus.h"
#include <QTimer>
#include<QVariant>
void qmodbus::run(){
    QModbusTcpClient mc;
    QTimer tim_event_timer;
    tim_event_timer.setSingleShot(true);
    QVector<quint16> tab(2);
    QModbusDataUnit du(QModbusDataUnit::HoldingRegisters,10,tab);
    QModbusReply *reply;
    //odpowiedź modbusa
    auto rpl_redy =[&](){
        if(!reply->error()){
            emit updateData(id, reply->result().value(0),reply->result().value(1));
            tim_event_timer.start(1000);
        }else{
            exit();
        }
        reply->deleteLater();
    };
    //zdarzenie timera
    auto timeout= [&](){
        reply=mc.sendReadRequest(du,255);
        if(reply->isFinished()){
            delete reply;
        }else{
            connect(reply,&QModbusReply::finished,rpl_redy);
        }
    };
    //zmiana stanu urządzenia modbusa
    auto stateChange = [&](QModbusClient::State state){
        if (state==QModbusClient::ConnectedState){
            tim_event_timer.start(1000);
        }else if(state==QModbusClient::UnconnectedState) {
            exit();
        }
    };
    connect(&tim_event_timer,&QTimer::timeout,timeout);
    connect(&mc, &QModbusClient::stateChanged,stateChange);
    mc.setConnectionParameter(QModbusDevice::NetworkAddressParameter, "127.0.0.1");
    mc.setConnectionParameter(QModbusDevice::NetworkPortParameter,502);
    mc.setTimeout(500);
    if (!mc.connectDevice()){
        exit();
        return;
    }
    exec();
}

qmodbus::qmodbus(QObject *parent) : QThread(parent)
{

}
