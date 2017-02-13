# -*- coding: utf-8 -*-
import datetime
import locale

import sphinx.environment
from docutils.utils import get_source_line

import tinkerer
import tinkerer.paths

# Change this to the name of your blog
project = 'Robert Zaremba blog'

# Change this to the tagline of your blog
tagline = 'Information Technology and programming thoughts by Robert Zaremba'

# Change this to your name
author = 'Robert Zaremba'

# Change this to your copyright string
copyright = '{}, {}'.format(datetime.date.today().year, author)

# Change this to your blog root URL (required for RSS feed)
website = 'http://rz.scale-it.pl/'

# **************************************************************
# More tweaks you can do
# **************************************************************

# Add your Disqus shortname to enable comments powered by Disqus
disqus_shortname = 'rz-scaleit'

# Change your favicon (new favicon goes in _static directory)
html_favicon = 'tinkerer.ico'

# Pick another Tinkerer theme or use your own
#html_theme = "boilerplate4"
html_theme = "robert"

# Theme-specific options, see docs
html_theme_options = { }

# Link to RSS service like FeedBurner if any, otherwise feed is
# linked directly
rss_service = None
#rss_tags = ['python']

# Number of blog posts per page
posts_per_page = 4

# **************************************************************
# Edit lines below to further customize Sphinx build
# **************************************************************

# Add other Sphinx extensions here
# sphintxtogithub (need to install package https://github.com/michaeljones/sphinx-to-github) is required due to special threatment top level _* directories (it doesn't allow to display them)
#   this extension will move every _* entry to *
#   http://stackoverflow.com/questions/6397780/names-starting-with-underscore-shows-errors-page-doesnot-exists-for-gh-pages-bra/6398875#6398875
#   BETTER SOLUTION IS TO USE .nojekyll file in top repository directory
extensions = ['tinkerer.ext.blog', 'tinkerer.ext.disqus',
              'tinkerer.ext.withgithub', 'tinkerer.ext.compressassets']

# Add other template paths here
templates_path = ['_templates']

# Add other static paths here
html_static_path = ['static', tinkerer.paths.static]

# Add other theme paths here
html_theme_path = ['themes', tinkerer.paths.themes]

# Add file patterns to exclude from build
exclude_patterns = ["drafts/*"]

# Add templates to be rendered in sidebar here
html_sidebars = {
    "**": ["me.html", "recent.html", "searchbox.html", "tags.html"]
}

language = "en"


# config for tinkerer.ext.compressassets
assets_css = ['normalize.css', 'main.css', 'pygments.css', 'webfont.css']

# **************************************************************
# Do not modify below lines as the values are required by
# Tinkerer to play nice with Sphinx
# **************************************************************

source_suffix = tinkerer.source_suffix
master_doc = tinkerer.master_doc
version = tinkerer.__version__
release = tinkerer.__version__
html_title = project
html_use_index = False
html_show_sourcelink = False
html_add_permalinks = None


# ***************
# custom setting

locale.resetlocale()


# ***************
# monkey pathing


# http://stackoverflow.com/questions/12772927/specifying-an-online-image-in-sphinx-restructuredtext-format
# other: https://github.com/sphinx-doc/sphinx/issues/1895
def _warn_node(self, msg, node, **kwargs):
    if not msg.startswith('nonlocal image URI found:'):
        self._warnfunc(msg, '%s:%s' % get_source_line(node), **kwargs)


sphinx.environment.BuildEnvironment.warn_node = _warn_node
