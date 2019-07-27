#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "settings.h"
#include "utility.h"
#include "dicomimageprovider.h"
#include "dicomtagsmodel.h"

#include <QDebug>


int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);
    app.setOrganizationName(QString::fromStdString(app::getCompanyName()));
    app.setOrganizationDomain(QString::fromStdString(app::getCompanyDomain()));
    app.setApplicationName(QString::fromStdString(app::getAppName()));
    qmlRegisterSingletonType<app::Utility>("App.Utility", 1, 0, "Utility", app::utilityProvider);

    QQmlApplicationEngine engine;
    engine.addImageProvider(QLatin1String("dcm"), new app::dicom::DicomImageProvider());
    DicomTagsModel model;
    engine.rootContext()->setContextProperty("dicomTagsModel",&model);
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
