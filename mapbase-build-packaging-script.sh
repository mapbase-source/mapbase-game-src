# =====================================================================================================
#
# Mapbase Build Packaging Script by Blixibon
#
# This is a shell script I created a few years ago to make it easier for me to package Mapbase builds.
# I've tried to adapt it for more general use, but it may not be an ideal solution for everyone.
#
# To set up this script on your machine, you must have certain folders for the script to draw files from.
# For that, you can follow these steps:
#
#		1.	Extract the VMT (material) files from HL2, EP1, EP2, and Lost Coast. All of these can be found
#			in Source SDK Base 2013 Singleplayer if you do not have the relevant games installed.
#
#		2.	Use the Mapbase Multi-Tool to convert those materials to the new shaders. Send them to new
#			"VPKs/hl2_materials_source", "VPKs/episodic_materials_source", and "VPKs/lostcoast_materials_source"
#			folders in this repository. For episodic_materials_source, make sure the EP2 materials are converted
#			after the EP1 materials so that the former group overwrites the latter.
#
#		3.	Have your own copies of Mapbase's source-sdk-2013 and source-fgds repositories on your computer.
#			Preferably, you should use Git with them.
#
#		4.	Tweak the directory variables below.
#
# With all of that done, you should be ready to create Mapbase builds.
#
# =====================================================================================================

# Where vpk.exe and its dependencies are on your computer
BIN_DIR="C:/Program\ Files\ \(x86\)/Steam/SteamApps/common/Source\ SDK\ Base\ 2013\ Singleplayer/bin"

# This repository's 'VPKs' folder (used by vpk.exe)
VPK_CONTENT_DIR="E:/Mapbase/mapbase-game-src/VPKs"

# Where the DLLs and SDK tools are
SOURCE_BIN_DIR="../mapbase-hl2-master/sp/game/bin"
SOURCE_MOD_EPISODIC_DIR="../mapbase-hl2-master/sp/game/mod_episodic"
SOURCE_MOD_HL2_DIR="../mapbase-hl2-master/sp/game/mod_hl2"

# Where the original games' VCD files are (they come with the code repo by default)
SOURCE_HL2_SCENES_DIR="../mapbase-hl2-master/sp/game/hl2/scenes"
SOURCE_EP1_SCENES_DIR="../mapbase-hl2-master/sp/game/episodic/scenes"
SOURCE_EP2_SCENES_DIR="../mapbase-hl2-master/sp/game/ep2/scenes"

# Where the FGDs are
SOURCE_FGDS_DIR="../source-fgds"

# "read VERSION" could've been used for this, but it doesn't change as frequently as builds
# are packaged, so it's only modified in the file and confirmed at runtime.
VERSION="v7_1"
VERSION_VPK_NAME="v7_0"

echo "The currently selected version is \"${VERSION}\""
echo "If this is correct, press enter to continue. If not, close this window and configure the version in the file."
read

BUILD_DIR_FOLDER="build_dir"

echo "Please enter a folder name to put the build into."
echo "It will appear in the 'BUILDS' folder of this repository."
read BUILD_DIR_FOLDER

mkdir BUILDS
BUILD_DIR="BUILDS/${BUILD_DIR_FOLDER}"
mkdir ${BUILD_DIR}

echo "====================="
echo "Copying loose folders"
echo "====================="

cp -r mapbase_episodic ${BUILD_DIR}
echo "mapbase_episodic copied"
cp -r mapbase_hl2 ${BUILD_DIR}
echo "mapbase_hl2 copied"
#cp mapbase_hl2mp ${BUILD_DIR}
#echo "mapbase_hl2mp copied"

echo "====================="
echo "Copying binaries from SDK bin"
echo "====================="

echo "Validating bin folders..."
mkdir ${BUILD_DIR}/mapbase_episodic/bin
mkdir ${BUILD_DIR}/mapbase_hl2/bin
#mkdir ${BUILD_DIR}/mapbase_hl2mp/bin

echo "Copying binaries from mapbase-hl2-master..."

cp ${SOURCE_MOD_EPISODIC_DIR}/bin/client.dll ${BUILD_DIR}/mapbase_episodic/bin
cp ${SOURCE_MOD_EPISODIC_DIR}/bin/server.dll ${BUILD_DIR}/mapbase_episodic/bin
cp ${SOURCE_MOD_EPISODIC_DIR}/bin/game_shader_dx9.dll ${BUILD_DIR}/mapbase_episodic/bin

cp ${SOURCE_MOD_HL2_DIR}/bin/client.dll ${BUILD_DIR}/mapbase_hl2/bin
cp ${SOURCE_MOD_HL2_DIR}/bin/server.dll ${BUILD_DIR}/mapbase_hl2/bin
cp ${SOURCE_MOD_HL2_DIR}/bin/game_shader_dx9.dll ${BUILD_DIR}/mapbase_hl2/bin

echo "====================="
echo "Copying compile tools from SDK bin"
echo "====================="

mkdir ${BUILD_DIR}/mapbase_engine_bin
cp ${SOURCE_BIN_DIR}/vbsp.exe ${BUILD_DIR}/mapbase_engine_bin
cp ${SOURCE_BIN_DIR}/vrad.exe ${BUILD_DIR}/mapbase_engine_bin
cp ${SOURCE_BIN_DIR}/vrad_dll.dll ${BUILD_DIR}/mapbase_engine_bin
cp ${SOURCE_BIN_DIR}/vvis.exe ${BUILD_DIR}/mapbase_engine_bin
cp ${SOURCE_BIN_DIR}/vvis_dll.dll ${BUILD_DIR}/mapbase_engine_bin

echo "====================="
echo "Copying materials"
echo "====================="

cp -r VPKs/hl2_materials_source VPKs/hl2_materials
echo "hl2_materials_source copied"
cp -r VPKs/hl2_materials_overrides/materials VPKs/hl2_materials
echo "hl2_materials_overrides copied"

cp -r VPKs/episodic_materials_source VPKs/episodic_materials
echo "episodic_materials_source copied"
cp -r VPKs/episodic_materials_overrides/materials VPKs/episodic_materials
echo "episodic_materials_overrides copied"

cp -r VPKs/lostcoast_materials_source VPKs/lostcoast_materials
echo "lostcoast_materials_source copied"
cp -r VPKs/lostcoast_materials_overrides/materials VPKs/lostcoast_materials
echo "lostcoast_materials_overrides copied"

echo "====================="
echo "Copying scenes"
echo "====================="

mkdir VPKs/hl2_scenes
mkdir VPKs/episodic_scenes

cp -r ${SOURCE_HL2_SCENES_DIR} VPKs/hl2_scenes
echo "HL2 scenes copied"
cp -r ${SOURCE_EP1_SCENES_DIR} VPKs/episodic_scenes
echo "EP1 scenes copied"
cp -r ${SOURCE_EP2_SCENES_DIR} VPKs/episodic_scenes
echo "EP2 scenes copied"

echo "====================="
echo "Packing VPKs"
echo "====================="

mkdir ${BUILD_DIR}/mapbase_shared
mkdir ${BUILD_DIR}/mapbase_episodic/content
mkdir ${BUILD_DIR}/mapbase_hl2/content

eval "${BIN_DIR}/vpk.exe generate_keypair \"mapbase_${VERSION}\""

eval "${BIN_DIR}/vpk.exe -M -P -c 50 -k mapbase_${VERSION}.publickey.vdf -K mapbase_${VERSION}.privatekey.vdf -vpk \"${VPK_CONTENT_DIR}/shared_content_${VERSION_VPK_NAME}\""
eval "${BIN_DIR}/vpk.exe rehash \"${VPK_CONTENT_DIR}/shared_content_${VERSION_VPK_NAME}\""
echo "Moving shared_content_${VERSION_VPK_NAME}"
mv VPKs/*.vpk ${BUILD_DIR}/mapbase_shared

eval "${BIN_DIR}/vpk.exe -M -P -c 50 -k mapbase_${VERSION}.publickey.vdf -K mapbase_${VERSION}.privatekey.vdf -vpk \"${VPK_CONTENT_DIR}/hl2_mapbase_content\""
eval "${BIN_DIR}/vpk.exe rehash \"${VPK_CONTENT_DIR}/hl2_mapbase_content\""
echo "Moving hl2_mapbase_content"
mv VPKs/*.vpk ${BUILD_DIR}/mapbase_hl2/content

eval "${BIN_DIR}/vpk.exe -M -P -c 50 -k mapbase_${VERSION}.publickey.vdf -K mapbase_${VERSION}.privatekey.vdf -vpk \"${VPK_CONTENT_DIR}/hl2_materials\""
eval "${BIN_DIR}/vpk.exe rehash \"${VPK_CONTENT_DIR}/hl2_materials\""
echo "Moving hl2_materials"
mv VPKs/*.vpk ${BUILD_DIR}/mapbase_hl2/content

eval "${BIN_DIR}/vpk.exe -M -P -c 50 -k mapbase_${VERSION}.publickey.vdf -K mapbase_${VERSION}.privatekey.vdf -vpk \"${VPK_CONTENT_DIR}/hl2_scenes\""
eval "${BIN_DIR}/vpk.exe rehash \"${VPK_CONTENT_DIR}/hl2_scenes\""
echo "Moving hl2_scenes"
mv VPKs/*.vpk ${BUILD_DIR}/mapbase_hl2/content

eval "${BIN_DIR}/vpk.exe -M -P -c 50 -k mapbase_${VERSION}.publickey.vdf -K mapbase_${VERSION}.privatekey.vdf -vpk \"${VPK_CONTENT_DIR}/lostcoast_materials\""
eval "${BIN_DIR}/vpk.exe rehash \"${VPK_CONTENT_DIR}/lostcoast_materials\""
echo "Moving lostcoast_materials"
mv VPKs/*.vpk ${BUILD_DIR}/mapbase_hl2/content

eval "${BIN_DIR}/vpk.exe -M -P -c 50 -k mapbase_${VERSION}.publickey.vdf -K mapbase_${VERSION}.privatekey.vdf -vpk \"${VPK_CONTENT_DIR}/episodic_mapbase_content\""
eval "${BIN_DIR}/vpk.exe rehash \"${VPK_CONTENT_DIR}/episodic_mapbase_content\""
echo "Moving episodic_mapbase_content"
mv VPKs/*.vpk ${BUILD_DIR}/mapbase_episodic/content

eval "${BIN_DIR}/vpk.exe -M -P -c 50 -k mapbase_${VERSION}.publickey.vdf -K mapbase_${VERSION}.privatekey.vdf -vpk \"${VPK_CONTENT_DIR}/episodic_materials\""
eval "${BIN_DIR}/vpk.exe rehash \"${VPK_CONTENT_DIR}/episodic_materials\""
echo "Moving episodic_materials"
mv VPKs/*.vpk ${BUILD_DIR}/mapbase_episodic/content

eval "${BIN_DIR}/vpk.exe -M -P -c 50 -k mapbase_${VERSION}.publickey.vdf -K mapbase_${VERSION}.privatekey.vdf -vpk \"${VPK_CONTENT_DIR}/episodic_scenes\""
eval "${BIN_DIR}/vpk.exe rehash \"${VPK_CONTENT_DIR}/episodic_scenes\""
echo "Moving episodic_scenes"
mv VPKs/*.vpk ${BUILD_DIR}/mapbase_episodic/content

echo "====================="
echo "Copying FGDs"
echo "====================="

mkdir ${BUILD_DIR}/mapbase_shared/shared_misc
mkdir ${BUILD_DIR}/mapbase_shared/shared_misc/bin

cp ${SOURCE_FGDS_DIR}/base.fgd ${BUILD_DIR}/mapbase_shared/shared_misc/bin
echo "base.fgd copied"
cp ${SOURCE_FGDS_DIR}/halflife2.fgd ${BUILD_DIR}/mapbase_shared/shared_misc/bin
echo "halflife2.fgd copied"

echo "====================="
echo "Copying READMEs"
echo "====================="

cp README.txt ${BUILD_DIR}
echo "README.txt copied"
cp MAPBASE_CONTENT_USAGE.txt ${BUILD_DIR}
echo "MAPBASE_CONTENT_USAGE.txt copied"

echo "====================="
echo "Cleaning up files"
echo "====================="

rm -r VPKs/episodic_materials
echo "Loose episodic_materials removed"
rm -r VPKs/hl2_materials
echo "Loose hl2_materials removed"
rm -r VPKs/lostcoast_materials
echo "Loose lostcoast_materials removed"
rm -r VPKs/episodic_scenes
echo "Loose episodic_scenes removed"
rm -r VPKs/hl2_scenes
echo "Loose hl2_scenes removed"

echo "====================="
echo "Verifying files"
echo "====================="

mkdir ${BUILD_DIR}/mapbase_episodic/custom
mkdir ${BUILD_DIR}/mapbase_hl2/custom

mkdir ${BUILD_DIR}/mapbase_episodic/maps
mkdir ${BUILD_DIR}/mapbase_hl2/maps

if [ -e ${BUILD_DIR}/mapbase_episodic/bin/game_shader_dx9.dll ]
then
	echo "	Exists: mapbase_episodic/bin/game_shader_dx9.dll"
else
	echo "	*** WARNING: game_shader_dx9.dll missing from mapbase_episodic"
fi

if [ -e ${BUILD_DIR}/mapbase_hl2/bin/game_shader_dx9.dll ]
then
	echo "	Exists: mapbase_hl2/bin/game_shader_dx9.dll"
else
	echo "	*** WARNING: game_shader_dx9.dll missing from mapbase_hl2"
fi

if [ -e ${BUILD_DIR}/mapbase_shared/shared_content_dir.vpk ]
then
	echo "	Exists: Legacy pre-v7.0 shared_content_dir.vpk"
else
	echo "	*** WARNING: Legacy pre-v7.0 shared_content_dir.vpk missing from mapbase_shared"
fi
	
echo "If any files are missing, you may just need to copy them from an existing version of the build."

echo "Done! Press enter to continue"
read