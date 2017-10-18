Stop publishing PDF
===================



.. author:: default
.. categories:: none
.. tags:: none
.. comments::


PDF, currently, is the dominant file format in the internet. You can see it everywhere: documentations, manuals, research papers, white papers, yellow papers ...

`PDF <https://en.wikipedia.org/wiki/Portable_Document_Format>`_, Portable Document Format, is a complex file format to present documents without being dependent on the platform (hardware, OS).

PDF is NOT portable in the digital world
----------------------------------------

The title might sound suspicious, but this is what I mean by digital world: the robots (and applications), which are parsing and consuming the data, and people who are using multiple, different devices to consume the content in a friendly manner.

This days most of the content is consumed by digital devices. There are many initiatives promoting environmental conscious life and work style (e.g. not printing the documents, emails ...). With smartphones, tablets and ebook readers the digital content is even more accessible for an average user. Instead of going with a bag of papers we can use digital devices to easily store, and read documents whenever we will like. Life should be easy, right?

PDF is not portable on digital screens. It doesn't scale. It's not comfortable to read PDF files on a mobile or ebook readers (which, is my favorite way to read documents). Even for the printed documents, people don't agree on the paper size (US Letter vs A4 ...).

PDF is not easy for parsing and data-mining. The format doesn't carry any knowledge representation. You can't connect the "dots" (piece of information) in the PDF document and easily parse it. Other formats are more friendly. For example: HTML has OWL extensions which embeds ontology into the document elements.

Moreover It's not easier to create the PDF document. You need to think more about the design and typesetting. Having formats which automatically construct the document flow (eg HTML) and editors which will do it automatically, we can focus on the content rather than design.

How about typesetting? Sure, if you want to publish a good-looking book, than you need to care about typesetting. Though majority of documents are not published as books. Even so, popular auto-adjustable formats will compose the content into nice looking paper publications.
PDF documents has it's use-cases (aforementioned complex typesetting, interactive forms, ...) - but as discussed here, it's not the best neither the simplest for common publications.


Finally all popular devices have ready to install EPUB, MOBI or HTML viewers.

Call
----

So here is my call:
Stop using PDF for internet publications unless you have rigid typesetting requirements (e.g. books with non-trivial design). Try:

+ `EPUB <https://en.wikipedia.org/wiki/EPUB>`_ - which is basically the HTML page with all dependencies bundled into a zip file.
+ any other markup language, which can easily generate EPUB or HTML.
+ Google Docs (they scale well and you can easily export to docx, epub and PDF when needed).
+ Publish in multiple format if you want to stick with PDF for some reson.

Let's make the life easier for digital users.
