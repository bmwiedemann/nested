#!/usr/bin/env python

import os
import shutil

where_am_i = os.path.normpath(os.path.dirname(os.path.abspath(os.path.realpath(__file__))))
os.chdir(where_am_i)

import msgfmt

def build_mo_files():
    """Compile avalaible localization files"""
    
    APP = "nested"
    locale_dir = 'mo'
    po_dir = 'po'

    if os.path.exists(locale_dir):
        shutil.rmtree(locale_dir)
    os.mkdir(locale_dir)

    available_langs = os.listdir(po_dir)
    available_langs = filter(lambda file: file.endswith('.po'), available_langs)
    available_langs = map(lambda file: file[:-3], available_langs)

    print 'Languages: ', available_langs

    for lang in available_langs:
        po_file = os.path.join(po_dir, lang + '.po')
        lang_dir = os.path.join(locale_dir, lang)
        mo_dir = os.path.join(lang_dir, 'LC_MESSAGES')
        mo_file = os.path.join(mo_dir, APP + '.mo')
        
        if not os.path.exists(mo_dir):
            os.makedirs(mo_dir)
        
        print('Compiling {0} to {1}'.format(po_file, mo_file))
        msgfmt.make(po_file, mo_file)

if __name__ == '__main__':
    build_mo_files()
