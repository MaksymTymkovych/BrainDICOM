#ifndef UTILITY_H
#define UTILITY_H

#include <QObject>
#include <QString>
#include <QFileInfo>
#include <QQmlEngine>
#include <QJSEngine>

namespace app {


class Utility : public QObject
{
    Q_OBJECT
public:
    explicit Utility(QObject *parent = nullptr);

    Q_INVOKABLE QString extractFileNameFromPath(const QString& filePath) const
    {
        return QFileInfo(filePath).fileName();
    }

    Q_INVOKABLE bool fileExists(const QString& filePath) const
    {
        QString fileName(QUrl(filePath).toLocalFile());
        return QFileInfo::exists(fileName);
    }

signals:

public slots:
};

static QObject* utilityProvider(QQmlEngine *engine, QJSEngine *scriptEngine)
{
    Q_UNUSED(engine)
    Q_UNUSED(scriptEngine)

    Utility *utility = new Utility();
    return utility;
}

}



#endif // UTILITY_H
