#ifndef DICOMIMAGEPROVIDER_H
#define DICOMIMAGEPROVIDER_H

#include <QDebug>
#include <QFile>
#include <QFileInfo>
#include <QQuickImageProvider>

#include "dcmtk/config/osconfig.h"
#include "dcmtk/dcmdata/dctk.h"
#include "dcmtk/dcmdata/dcfilefo.h"
#include "dcmtk/dcmdata/dcdeftag.h"
#include "dcmtk/dcmimgle/didocu.h"
#include "dcmtk/dcmimgle/diutils.h"
#include "dcmtk/dcmimgle/dcmimage.h"


#include <string>

//https://doc.qt.io/qt-5/qquickimageprovider.html
//https://stackoverflow.com/questions/23667088/qtquick-dynamic-images-and-c
namespace app::dicom {


class DicomImageProvider : public QQuickImageProvider
{
public:
    DicomImageProvider() : QQuickImageProvider(QQuickImageProvider::Pixmap)
    {


    }


    QPixmap requestPixmap(const QString &id, QSize *size, const QSize &requestedSize) override
    {
        QString fileName(QUrl("file:///"+id).toLocalFile());
        QFile file(fileName);
        if (QFileInfo::exists(fileName)) {
            DicomImage *image = new DicomImage(fileName.toStdString().c_str());

            QPixmap pixmap;
            if (image != nullptr)
            {
              if (image->getStatus() == EIS_Normal)
              {
                int width = image->getWidth();
                int height = image->getHeight();
                if (size)
                   *size = QSize(width, height);
                unsigned char *pixelData = (unsigned char *)(image->getOutputData(8));
                if (pixelData != nullptr)
                {
                    pixmap = QPixmap::fromImage(
                        QImage(
                            pixelData,
                            width,
                            height,
                            QImage::Format_Grayscale8
                        )
                    );
                }
              } else {
                int width = 0;
                int height = 0;
                if (size)
                   *size = QSize(width, height);
                //qDebug()<<"Error image reading";
                pixmap = QPixmap{requestedSize.width() > 0 ? requestedSize.width() : width,
                          requestedSize.height() > 0 ? requestedSize.height() : height};
                pixmap.fill(QColor("red").rgba());
              }
            }
            delete image;




            return pixmap;
        } else {

            int width = 0;
            int height = 0;
            if (size)
               *size = QSize(width, height);
            QPixmap pixmap(requestedSize.width() > 0 ? requestedSize.width() : width,
                           requestedSize.height() > 0 ? requestedSize.height() : height);
            pixmap.fill(QColor("yellow").rgba());//id
            return pixmap;
        }


    }
};

}

#endif // DICOMIMAGEPROVIDER_H
