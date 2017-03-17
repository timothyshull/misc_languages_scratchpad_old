#!/usr/bin/python

import os
import glob
import re
import shutil

from tempfile import mkstemp

from xml.etree import ElementTree
from xml.etree.ElementTree import Element

from xml.dom import minidom

DOCUMENTATION = '''
---
module: glob_find
short_description:
description:
   -
version_added: "2.1.0"
options:
  file:
    description:
      -
    required: True
  xml_string:
    description:
      -
    required: False
  action:
    description:
      -
    required: False
  namespace:
    description:
      -
    required: False
  value_dict:
    description:
      -
    required: False
  xml_str:
    description:
      -
    required: False
  value_tag:
    description:
      -
    required: False
  pretty_print:
    description:
      -
    required: False
'''

EXAMPLES = '''
# Basic module usage
'''


class ModifyXML:
    def __init__(self, module):
        self.module = module
        self.action = self.module.params.get('action')
        self.check_module_args()

        self.file = self.module.params.get('file')
        self.fd = None
        self.tmp_file = None
        self.tmp_path = None

        if self.module.params.get('xml_string', None):
            try:
                self.tree = ElementTree.fromstring(self.module.params['xml_string'])
            except (EnvironmentError, Exception) as e:
                self.module.fail_json(msg='An error occurred while attempting to parse the '
                                          'XML file {0}: {1}'.format(self.module.params['file'], e.message), rc=1)
        else:
            try:
                self.tree = ElementTree.parse(self.module.params['file'])
            except (EnvironmentError, Exception) as e:
                self.module.fail_json(msg='An error occurred while attempting to parse the '
                                          'XML file {0}: {1}'.format(self.module.params['file'], e.message), rc=1)
        self.root = self.tree.getroot()
        self.replacement_element = None
        self.set_replacement_element()

    def check_module_args(self):
        if self.module.params.get('file', None) and not os.path.isfile(os.path.expanduser(self.module.params['file'])):
            self.module.fail_json(msg='The file \'{0}\' is not a valid path'.format(self.module.params['file']), rc=1)

        if self.module.params.get('action') != 'remove' and \
                (self.module.params.get('value_str', None) is None and
                         self.module.params.get('value_dict', None) is None):
            self.module.fail_json(msg='One of the params \'value_str\' or \'value_dict\' must be defined if \'action\' '
                                      'is not \'remove\'', rc=1)

        if self.module.params.get('action') == 'replace' and (self.module.params.get('selector') == '/'
                                                              and self.module.params.get('namespace', None) is None):
            self.module.fail_json(msg='If the \'action\' is \'replace\' and no namespace is '
                                      'passed then a selector must be specified', rc=1)

        if self.module.params.get('action') == 'append' and \
                (self.module.params.get('value_tag', None) is None and
                         self.module.params.get('value_dict', None) is not None):
            self.module.fail_json(msg='If the \'action\' is \'append\' and a \'value_dict\' '
                                      'is passed, the \'value_tag\' parameter must be specified', rc=1)

        if self.module.params.get('namespace', None) is not None \
                and re.search('\W', self.module.params.get('selector')):
            self.module.fail_json(msg='A namespace cannot be used with an XPath selector', rc=1)

    def set_replacement_element(self):
        if self.module.params['action'] != 'remove':
            if self.module.params.get('value_str', None) is not None:
                try:
                    elem = ElementTree.fromstring(self.module.params['value_str'])
                    if self.module.params.get('value_tag', None) is not None:
                        self.replacement_element = Element(self.module.params.get('value_tag'))
                        self.replacement_element.append(elem)
                    else:
                        self.replacement_element = elem
                except Exception:  # throws ParseError
                    if self.module.params.get('value_tag', None) is None:
                        self.module.fail_json(msg='If the \'value_str\' is not well-formed XML, '
                                                  'the \'value_tag\' must be specified', rc=1)
                    self.replacement_element = Element(self.module.params.get('value_tag'))
                    self.replacement_element.text = self.module.params.get('value_str')
            else:
                tag = self.module.params.get('value_tag')
                tag = tag if tag else 'tmp'
                self.replacement_element = self.object_to_xml(tag, self.module.params['value_dict'])

    def loop_through_elements(self):
        if self.module.params.get('namespace', None) is not None:
            search_str = '{{0}}{1}'.format(self.module.params['namespace'], self.module.params['selector'])
        else:
            search_str = self.module.params['selector']

        for elem in self.root.findall(search_str):
            if self.action == 'replace':
                self.replace_xml_element(elem, self.replacement_element)
            elif self.action == 'append':
                elem.append(self.replacement_element)
            else:
                self.root.remove(elem)

    def object_to_xml(self, tag, obj):
        elem = Element(tag)
        if isinstance(obj, list):
            for val in obj:
                child = self.object_to_xml('value', val)
                elem.append(child)
        elif isinstance(obj, dict):
            for key, val in obj.items():
                child = self.object_to_xml(key, val)
                elem.append(child)
        else:
            elem.text = str(obj)

        return elem

    @staticmethod
    def replace_xml_element(orig, replacement):
        orig.attrib = replacement.attrib.copy()
        orig.tag = replacement.tag
        orig.text = replacement.text
        orig.tail = replacement.tail
        setattr(orig, '_children', getattr(replacement, '_children'))

    @staticmethod
    def print_xml(element, pretty_print=False):
        if pretty_print:
            parsed_xml = minidom.parseString(ElementTree.tostring(element, 'utf-8'))
            pretty_str = parsed_xml.toprettyxml(indent='    ')
            return os.linesep.join([elem for elem in pretty_str.splitlines() if elem.strip()])
        else:
            # the difference between these two options is that one adds the header and the other doesn't
            # return parsed_xml.toxml('utf-8')
            return ElementTree.tostring(element, 'utf-8')

    def perform_action(self):
        fd, tmp_path = mkstemp()
        self.fd = fd
        self.tmp_path = tmp_path
        self.tmp_file = open(self.tmp_path, 'w')
        self.loop_through_elements()

        self.tmp_file.write(self.print_xml(self.root, self.module.params['pretty_print']))

        self.tmp_file.close()
        os.close(self.fd)
        os.remove(self.file)
        shutil.move(self.tmp_path, self.file)
        self.module.exit_json(msg='Successfully updated the file {0}'.format(self.file), rc=0)


def test_module(module):
    pass


def main():
    module = AnsibleModule(
        argument_spec=dict(
            file=dict(required=True),
            xml_string=dict(required=False, default=''),
            selector=dict(required=False, default='/', type='str'),
            namespace=dict(required=False, type='str'),
            value_dict=dict(required=False, type='dict'),
            value_str=dict(required=False, type='str'),
            value_tag=dict(required=False, type='str'),
            pretty_print=dict(required=False, default=True, type='bool'),
            action=dict(required=True, default=None, choices=['replace', 'append', 'remove']),
        ),
        supports_check_mode=True,
        mutually_exclusive=[
            ['value_dict', 'value_str']
        ]
    )

    mxm = ModifyXML(module)
    mxm.perform_action()


# import module snippets
from ansible.module_utils.basic import *

if __name__ == '__main__':
    main()
