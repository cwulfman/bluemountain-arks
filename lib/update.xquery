xquery version "3.0";

declare namespace mods="http://www.loc.gov/mods/v3";
declare namespace mets="http://www.loc.gov/METS/";

let $source := fn:doc("/tmp/convertcsv.xml")
for $row in $source/ROWSET/ROW
    let $doc := fn:doc($row/file)
    let $ark := $row/identifier/text()
    let $metsID :=
        element mets:altRecordID {
            attribute TYPE { "ark" },
            attribute ID { $ark }
        }
    let $modsID :=
        element mods:identifier {
            attribute type { "ark" },
            $ark
        }
    let $mods  := $doc//mods:mods
    let $metsHdr := $doc//mets:metsHdr
    return
    (insert nodes $metsID as first into $metsHdr,
    if ($mods) then
         insert nodes $modsID  as first into $mods
    else 
         ()
    )