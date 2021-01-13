#ifndef QMODBUS_H
#define QMODBUS_H

#include <QThread>
#include<QModbusTcpClient>
class qmodbus : public QThread
{
    Q_OBJECT
    int id=1;
    void run();
public:
    explicit qmodbus(QObject *parent = nullptr);

signals:
    void updateData(int _id,int temperature,int _level);
};

#endif // QMODBUS_H
