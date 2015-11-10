#!/usr/bin/env python

# Inspired by https://github.com/vheon/dotvim

def FlagsForFile(filename, **kwargs):
    flags = [
        '-isystem', '/usr/include',
        '-isystem', '/usr/local/include',
        '-isystem', '/usr/include/c++/5.2.0',
        '-Wall',
        '-Wextra',
        '-pedantic',
    ]

    filetype = kwargs['client_data']['&filetype']

    if filetype == 'c':
        flags += [
            '-x', 'c',
            '-std=gnu11',
        ]
    elif filetype == 'cpp':
        flags += [
            '-x', 'c++',
            '-std=c++14',
        ]

    return {
        'flags': flags,
        'do_cache': True,
    }
