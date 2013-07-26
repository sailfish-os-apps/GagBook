/*
 * Copyright (c) 2012-2013 Dickson Leong.
 * All rights reserved.
 *
 * This file is part of GagBook.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 *     * Redistributions of source code must retain the above copyright
 *       notice, this list of conditions and the following disclaimer.
 *     * Redistributions in binary form must reproduce the above copyright
 *       notice, this list of conditions and the following disclaimer in the
 *       documentation and/or other materials provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
 * ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#ifndef NETWORKMANAGER_H
#define NETWORKMANAGER_H

#include <QtCore/QObject>
#include <QtCore/QScopedPointer>

class QNetworkAccessManager;
class QNetworkReply;
class QUrl;

class NetworkManager : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString downloadCounter READ downloadCounter NOTIFY downloadCounterChanged)
public:
    enum AcceptType {
        None,
        JSON,
        HTML,
        Image
    };

    static NetworkManager *instance();
    static QNetworkReply *createGetRequest(const QUrl &url, AcceptType acceptType = None);

    static bool isMobileData();

    QString downloadCounter() const { return m_downloadCounterStr; }

signals:
    void downloadCounterChanged();

private slots:
    void increaseDownloadCounter(QNetworkReply *reply);

private:
    static QScopedPointer<NetworkManager> m_instance;

    explicit NetworkManager(QObject *parent = 0);
    Q_DISABLE_COPY(NetworkManager)

    QNetworkAccessManager *m_networkAccessManager;

    qint64 m_downloadCounter; // in bytes
    QString m_downloadCounterStr; // in MB
};

#endif // NETWORKMANAGER_H
