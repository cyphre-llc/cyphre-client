set( APPLICATION_NAME       "Cyphre" )
#set( APPLICATION_SHORTNAME  ${APPLICATION_NAME} )
set( APPLICATION_EXECUTABLE "Cyphre" )
set( APPLICATION_DOMAIN     "cyphre.com" )
set( APPLICATION_VENDOR     "Cyphre" )
set( APPLICATION_UPDATE_URL "https://updates.cyphre.com/client/" CACHE string "URL for updater" )

set( THEME_CLASS            "ownCloudTheme" )
set( APPLICATION_REV_DOMAIN "com.cyphre.desktopclient" )
set( WIN_SETUP_BITMAP_PATH  "${CMAKE_SOURCE_DIR}/Cyphre" )

set( MAC_INSTALLER_BACKGROUND_FILE "${CMAKE_SOURCE_DIR}/Cyphre/installer-background.png" CACHE STRING "The MacOSX installer background image")

# set( THEME_INCLUDE          "${OEM_THEME_DIR}/cyphretheme.h" )
# set( APPLICATION_LICENSE    "${OEM_THEME_DIR}/license.txt )

set( OSX_INSTALLER_LOGO "Cyphre/Cyphre_logo_blue.png" )
