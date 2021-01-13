#include "coreProg.h"
#include<QTimer>

coreProg::coreProg(QObject *parent) : QObject(parent)
{
    mbus=new qmodbus(this);
    connect(mbus,&qmodbus::finished,this,[this](){
       QTimer::singleShot(10000,mbus,SLOT(start()));
    });
    connect(mbus,SIGNAL(updateData(int,int, int)),this,SIGNAL(updateData(int, int, int)));
}

coreProg::~coreProg()
{
    mbus->exit();
    mbus->wait();
}

void coreProg::start()
{

    mbus->start();

}
