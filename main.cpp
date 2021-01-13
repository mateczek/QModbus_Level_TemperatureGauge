#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include<coreProg.h>
#include<QString>
int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;
    coreProg core;
    core.start();
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated, &app, [&](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
        QObject::connect(&core,&coreProg::updateData,[=](int id, int temperature,int level){
            obj->setProperty("temperature1",temperature);
            obj->setProperty("level1",level);
        });
    }, Qt::QueuedConnection);
    engine.load(url);
    app.exec();
    return 0;
}
