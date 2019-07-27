#ifndef DICOMTAGSMODEL_H
#define DICOMTAGSMODEL_H


#include <QAbstractListModel>
#include <QString>
#include <QList>
#include <QHash>
#include <QUrl>
#include <QDebug>

#include "dcmtk/dcmdata/dctk.h"
#include "dcmtk/dcmdata/dcfilefo.h"
#include "dcmtk/dcmdata/dcdeftag.h"
#include "dcmtk/dcmimgle/didocu.h"
#include "dcmtk/dcmimgle/diutils.h"
#include "dcmtk/dcmimgle/dcmimage.h"

class DicomTag
{
public:
    DicomTag(const QString &tagId, const QString &vr, const QString &vm,
             const QString &length, const QString &description, const QString value)
    {
        m_tagId = tagId;
        m_vr = vr;
        m_vm = vm;
        m_length = length;
        m_description = description;
        m_value = value;
    }

    void setTagId(const QString &tagId)
    {
        m_tagId = tagId;
    }

    void setVr(const QString &vr)
    {
        m_vr = vr;
    }

    void setVm(const QString &vm)
    {
        m_vm = vm;
    }

    void setLength(const QString &length)
    {
        m_length = length;
    }

    void setDescription(const QString &description)
    {
        m_description = description;
    }

    void setValue(const QString &value)
    {
        m_value = value;
    }

    QString getTagId() const
    {
        return m_tagId;
    }

    QString getVr() const
    {
        return m_vr;
    }

    QString getVm() const
    {
        return m_vm;
    }

    QString getLength() const
    {
        return m_length;
    }

    QString getDescription() const
    {
        return m_description;
    }

    QString getValue() const
    {
        return m_value;
    }

private:
    QString m_tagId;
    QString m_vr;
    QString m_vm;
    QString m_length;
    QString m_description;
    QString m_value;
};

class DicomTagsModel : public QAbstractListModel
{
    Q_OBJECT
public:

    enum TagsRoles {
        TagIdRole = Qt::DisplayRole,
        VrRole = Qt::UserRole + 1,
        VmRole,
        LengthRole,
        DescriptionRole,
        ValueRole
    };

    explicit DicomTagsModel(QObject *parent = 0)
    {
        m_roles[TagIdRole] = "tagId";
        m_roles[VrRole] = "vr";
        m_roles[VmRole] = "vm";
        m_roles[LengthRole] = "length";
        m_roles[DescriptionRole] = "description";
        m_roles[ValueRole] = "value";
    }

    QHash<int, QByteArray> roleNames() const {
        return m_roles;
    }


    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const
    {
        if (index.row() < 0 || index.row() > m_tags.count())
            return QVariant();
        const DicomTag &tag = m_tags[index.row()];
        if (role == TagIdRole)
            return tag.getTagId();
        else if (role == VrRole)
            return tag.getVr();
        else if (role == VmRole)
            return tag.getVm();
        else if (role == LengthRole)
            return tag.getLength();
        else if (role == DescriptionRole)
            return tag.getDescription();
        else if (role == ValueRole)
            return tag.getValue();
        return QVariant();
    }

    int rowCount(const QModelIndex &parent) const
    {
        Q_UNUSED(parent);
        return m_tags.size();
    }

    Q_INVOKABLE bool clear()
    {
        beginRemoveRows(QModelIndex(), 0, m_tags.count()-1);
        m_tags.clear();
        endRemoveRows();
        return true;
    }

    Q_INVOKABLE bool loadFromFile(const QString &fileName)
    {
        QString fileNameReal(QUrl(fileName).toLocalFile());
        bool result = true;
        beginResetModel();
        m_tags.clear();
        //qDebug()<<fileNameReal;

        DcmFileFormat dcmFileFormat;
        OFCondition status = dcmFileFormat.loadFile(fileNameReal.toStdString().c_str());
        if (status.good())
        {
            DcmStack stack;
            DcmObject *dobject = nullptr;
            DcmElement *delem = nullptr;
            OFCondition status = dcmFileFormat.getDataset()->nextObject(stack, OFTrue);
            while (status.good())
            {
                dobject = stack.top();
                delem = (DcmElement *)dobject;

                bool isLeaf = delem->isLeaf();
                QString tag = delem->getTag().toString().c_str();
                if (isLeaf)
                {
                    OFString  value;
                    if (dcmFileFormat.getDataset()->findAndGetOFString(delem->getTag(), value).good())
                    {
                        Uint32 len = dobject->getLength();
                        unsigned long vm = dobject->getVM();
                        DcmTag dcmTag = delem->getTag();
                        QString tagName(dcmTag.getTagName());
                        addTag(DicomTag(tag,delem->getTag().getVRName(),QString::number(vm),QString::number(len),tagName,value.c_str()));
                        dcmDataDict.rdunlock();
                    }
                    else
                    {
                        //nop
                    }
                }
                else
                {
                    //mop
                }
                status = dcmFileFormat.getDataset()->nextObject(stack, OFTrue);
            }
        } else {
            result = false;
        }

        endResetModel();

        return result;
    }


public slots:
    void addTag(DicomTag tag)
    {
        m_tags << tag;
    }

private:
    QList<DicomTag> m_tags;
    QHash<int, QByteArray> m_roles;

};

#endif // DICOMTAGSMODEL_H
