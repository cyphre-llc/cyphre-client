/*
 * Copyright (C) by Olivier Goffart <ogoffart@owncloud.com>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; version 2 of the License.
 *
 * This program is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
 * or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
 * for more details.
 */

#pragma once

#include <QString>
#include <QFile>
#include <ctime>

#include <owncloudlib.h>

namespace OCC {

/**
 * This file contains file system helper.
 */

namespace FileSystem {

/** compare two files with given filename and return true if they have the same content */
bool fileEquals(const QString &fn1, const QString &fn2);

/** Mark the file as hidden  (only has effects on windows) */
void OWNCLOUDSYNC_EXPORT setFileHidden(const QString& filename, bool hidden);


/** Get the mtime for a filepath.
 *
 * Use this over QFileInfo::lastModified() to avoid timezone related bugs. See
 * owncloud/core#9781 for details.
 */
time_t OWNCLOUDSYNC_EXPORT getModTime(const QString &filename);

bool setModTime(const QString &filename, time_t modTime);

/** Get the size for a file.
 *
 * Use this over QFileInfo::size() to avoid bugs with lnk files on Windows.
 * See https://bugreports.qt.io/browse/QTBUG-24831.
 */
qint64 OWNCLOUDSYNC_EXPORT getSize(const QString& filename);

/**
 * Rename the file \a originFileName to \a destinationFileName, and overwrite the destination if it
 * already exists
 */
bool renameReplace(const QString &originFileName, const QString &destinationFileName,
                   QString *errorString);

/**
 * Replacement for QFile::open(ReadOnly) that sets a more permissive sharing mode
 * on Windows.
 *
 * Warning: The resuting file may have an empty fileName and be unsuitable for use
 * with QFileInfo!
 */
bool openFileSharedRead(QFile* file, QString* error);

#ifdef Q_OS_WIN
/**
 * Returns the file system used at the given path.
 */
QString fileSystemForPath(const QString & path);
#endif

}}
