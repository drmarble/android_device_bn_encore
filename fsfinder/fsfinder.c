/*
 * Copyright (C) 2014 Steven Luo
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#include <string.h>
#include <stdio.h>
#include <unistd.h>

#define CMDLINE_MAX 1024
#define BOOTDEVICE_PARAM "androidboot.bootdevice="
#define SYMLINKS_DIR "/dev/block/by-name/"

typedef enum {
	UNKNOWN,
	EMMC,
	SD,
} bootdevice_t;

static bootdevice_t parse_bootdevice_arg(char *arg) {
	return EMMC;
}

int main() {
	FILE *fp;
	char cmdline[CMDLINE_MAX];
	char *arg;
		if (symlink("/dev/block/mmcblk0p1", SYMLINKS_DIR "boot") ||
		    symlink("/dev/block/mmcblk0p6", SYMLINKS_DIR "userdata") ||
		    symlink("/dev/block/mmcblk0p5", SYMLINKS_DIR "system")) {
			perror("Creating device symlink failed");
			return 1;
		}
	return 0;
}
