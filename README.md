Embed PDF DITA-OT Plugin
========================

Point to a PDF file in your DITA map to have it embedded in your PDF file.

Supports [FOP][fop] and [Antenna House][ah].

**NOTE**: Requires [DITA-OT][dita-ot] 2.2.

## Use

```xml
<map>
  <!-- Embed entire PDF file -->
  <topicref href="file.pdf" format="pdf"/>

  <!-- Embed second page of PDF file -->
  <topicref href="file.pdf#page=2" format="pdf"/>

  <!-- Embed external PDF file -->
  <topicref href="http://www.stat.berkeley.edu/~census/sample.pdf"
            format="pdf"
            scope="external"/>
</map>
```

## Install

```bash
$ cd /path/to/dita-ot/plugins
$ git clone https://github.com/eerohele/fi.eerohele.embed-pdf.git
$ ant -f /path/to/dita-ot/integrator.xml
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