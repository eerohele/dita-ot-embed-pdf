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
$ dita -install <url>
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