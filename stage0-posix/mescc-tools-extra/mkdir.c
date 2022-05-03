/* Copyright (C) 2009 Tim Kientzle
 * Copyright (C) 2021 Jeremiah Orians
 * Copyright (C) 2021 Andrius Štikonas
 * This file is part of mescc-tools-extra
 *
 * mescc-tools-extra is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * mescc-tools-extra is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with mescc-tools-extra.  If not, see <http://www.gnu.org/licenses/>.
 */

/*
 * "mkdir" can be used to create empty directories. It can also create
 * required parent directories.
 *
 * Usage: mkdir <dir1>/<dir2> <dir3>
 *
 * These are all highly standard and portable headers. */
#include <stdio.h>
#include <string.h>

/* This is for mkdir(); this may need to be changed for some platforms. */
#include <sys/stat.h>  /* For mkdir() */
#include <stdlib.h>
#include "M2libc/bootstrappable.h"

int parents;

/* Create a directory, including parent directories as necessary. */
void create_dir(char *pathname, int mode)
{
	char *p;
	int r;

	/* Strip trailing '/' */
	if(pathname[strlen(pathname) - 1] == '/')
	{
		pathname[strlen(pathname) - 1] = '\0';
	}

	/* Try creating the directory. */
	r = mkdir(pathname, mode);

	if((r != 0) && parents)
	{
		/* On failure, try creating parent directory. */
		p = strrchr(pathname, '/');

		if(p != NULL)
		{
			p[0] = '\0';
			create_dir(pathname, 0755);
			p[0] = '/';
			r = mkdir(pathname, mode);
		}
	}

	if((r != 0) && !parents)
	{
		fputs("Could not create directory ", stderr);
		fputs(pathname, stderr);
		fputc('\n', stderr);
		exit(EXIT_FAILURE);
	}
}

int main(int argc, char **argv)
{
	/* This adds some quasi-compatibility with GNU coreutils' mkdir. */
	parents = FALSE;
	int i;
	for(i = 1; argc > i; i = i + 1)
	{
		if(match(argv[i], "-p")) parents = TRUE;
		else create_dir(argv[i], 0755);
	}

	return 0;
}
