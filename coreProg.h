#ifndef COREPROG_H
#define COREPROG_H

#include <QObject>
#include<qmodbus.h>
class coreProg : public QObject
{
    Q_OBJECT

    qmodbus* mbus;
public:
    explicit coreProg(QObject *parent = nullptr);
    ~coreProg();
    void start();
signals:
    void updateData(int id, int temperature, int level);
};

#endif // COREPROG_H
