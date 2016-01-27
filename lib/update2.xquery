xquery version "3.0";

declare default element namespace "http://www.loc.gov/METS/";
declare namespace bm="http://bluemountain.princeton.edu";

let $source := fn:doc("/tmp/arks.xml")
for $row in $source/bm:root/bm:row
    let $doc := fn:doc($row/bm:file)
    let $ark := $row/bm:identifier/text()
    let $metsID :=
        element altRecordID {
            attribute TYPE { "ark" },
             $ark 
        }
    
    let $metsHdr := $doc//metsHdr
    return
    if ($metsHdr/altRecordID) then
    (
    delete node $metsHdr/altRecordID,
    insert node $metsID after $metsHdr/agent[last()]
    )
    else if ($metsHdr/agent) then
    insert node $metsID after $metsHdr/agent[last()]
    else
    insert node metsHdr/$metsID as first into $doc/mets
   