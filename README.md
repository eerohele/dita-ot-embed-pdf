DITA-OT Embed PDF Plugin
========================

Embed a PDF document into the PDF file you generate from your DITA map.

Supports [FOP][fop] via the [fop-pdf-images plugin][fop-pdf-images] and
[Antenna House][ah].

**NOTE**: Requires [DITA-OT][dita-ot] 1.8.6+ or 2.2+.

## Use

```xml
<map>
  <!-- Embed entire PDF file -->
  <topicref href="file.pdf" format="pdf">
    <topicmeta>
      <navtitle>Title #1</navtitle>
    </topicmeta>
  </topicref>

  <!-- Embed second page of PDF file -->
  <topicref href="file.pdf#page=2" format="pdf">
    <topicmeta>
      <navtitle>Title #2</navtitle>
    </topicmeta>
  </topicref>

  <!-- Embed external PDF file -->
  <topicref href="http://www.stat.berkeley.edu/~census/sample.pdf"
            format="pdf"
            scope="external">
    <topicmeta>
      <navtitle>Title #3</navtitle>
    </topicmeta>
  </topicref>
</map>
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

- Can't embed a PDF in a nested topicref. So this won't work:

    ```xml
    <map>
      <topicref href="topic1.dita">
        <topicref href="file.pdf" format="pdf"/>
        ...
      </topicref>
    </map>
    ```

[ah]: http://www.antennahouse.com
[dita-ot]: http://www.dita-ot.org
[fop]: https://xmlgraphics.apache.org
[fop-pdf-images]: https://xmlgraphics.apache.org/fop/fop-pdf-images.html
[zip]: https://github.com/eerohele/dita-ot-embed-pdf/releases/download/0.1.0/fi.eerohele.embed-pdf-0.1.0.zip
