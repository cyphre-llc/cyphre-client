/*
 * Copyright (C) by Duncan Mac-Vicar P. <duncan@kde.org>
 * Copyright (C) by Klaas Freitag <freitag@kde.org>
 * Copyright (C) by Krzesimir Nowak <krzesimir@endocode.com>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
 * or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
 * for more details.
 */

#ifndef MIRALL_OWNCLOUD_WIZARD_RESULT_PAGE_H
#define MIRALL_OWNCLOUD_WIZARD_RESULT_PAGE_H

#include <QWizardPage>

#include "ui_owncloudwizardresultpage.h"

namespace Mirall {

class OwncloudWizardResultPage : public QWizardPage
{
  Q_OBJECT
public:
  OwncloudWizardResultPage();
  ~OwncloudWizardResultPage();

  bool isComplete() const;
  void initializePage();
  void setRemoteFolder( const QString& remoteFolder);

public slots:
  void setComplete(bool complete);

protected slots:
  void slotOpenLocal();
  void slotOpenServer();

protected:
  void setupCustomization();

private:
  QString _localFolder;
  QString _remoteFolder;
  bool _complete;

  Ui_OwncloudWizardResultPage _ui;
};

} // ns Mirall

#endif
