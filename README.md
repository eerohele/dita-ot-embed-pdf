DITA-OT Embed PDF Plugin
========================

Embed a PDF document into the PDF file you generate from your DITA map.

Supports [FOP][fop] via the [fop-pdf-images plugin][fop-pdf-images] and
[Antenna House][ah].

**Note**: Requires [DITA-OT][dita-ot] 1.8.6+ or 2.2+.

## Use

```xml
<bookmap>
  <!-- Embed entire PDF file -->
  <chapter href="file.pdf" format="pdf">
    <topicmeta>
      <navtitle>Title #1</navtitle>
    </topicmeta>
  </chapter>

  <!-- Embed second page of PDF file -->
  <chapter href="file.pdf#page=2" format="pdf">
    <topicmeta>
      <navtitle>Title #2</navtitle>
    </topicmeta>
  </chapter>

  <!-- Embed external PDF file -->
  <appendix href="http://www.stat.berkeley.edu/~census/sample.pdf"
            format="pdf"
            scope="external">
    <topicmeta>
      <navtitle>Title #3</navtitle>
    </topicmeta>
  </appendix>
</bookmap>
```

## Install

### DITA-OT 2.2+

```bash
$ dita -install https://github.com/eerohele/dita-ot-embed-pdf/releases/download/0.1.0/fi.eerohele.embed-pdf-0.1.0.zip
```

### DITA-OT 1.8.6+

1. Download [the plugin ZIP file][zip].
2. Extract the ZIP file into the `plugins` directory of your DITA-OT
   installation.
3. In the root directory of your DITA-OT installation, run:

    ```bash
    $ ant -f integrator.xml
    ```

## Limitations

- Doesn't work with [map-based page sequence generation][dita-ot #1685], which
  is the default behavior from DITA-OT 2.0 onwards. This plugin therefore
  disables map-based page sequence generation. You can re-enable it by adding
  this in your PDF plugin stylesheet:

  ```xml
  <xsl:variable name="map-based-page-sequence-generation" as="xs:boolean"
                  select="false()"/>
  ```

  **Note**: If you do this, you cannot embed PDFs in regular DITA maps (that is,
  DITA maps whose root element is `<map>`).

- Can't embed a PDF in a nested topicref. So this won't work:

    ```xml
    <bookmap>
      <chapter href="topic1.dita">
        <topicref href="file.pdf" format="pdf"/>
        ...
      </chapter>
    </bookmap>
    ```

[dita-ot #1685]: https://github.com/dita-ot/dita-ot/issues/1685
[ah]: http://www.antennahouse.com
[dita-ot]: http://www.dita-ot.org
[fop]: https://xmlgraphics.apache.org
[fop-pdf-images]: https://xmlgraphics.apache.org/fop/fop-pdf-images.html
[zip]: https://github.com/eerohele/dita-ot-embed-pdf/releases/download/0.1.0/fi.eerohele.embed-pdf-0.1.0.zip
