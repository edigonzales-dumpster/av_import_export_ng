# av_import_export_ng

## Modelle

### SO_AGI_MOpublic
DDL-erzeugen:
```
ILI2PG_PATH=/Users/stefan/apps/ili2pg-4.3.0/ili2pg-4.3.0.jar  
java -jar ${ILI2PG_PATH} \
--dbschema agi_mopublic_pub --models SO_AGI_MOpublic_20190424 --modeldir ".;http://models.geo.admin.ch" \
--defaultSrsCode 2056 --createGeomIdx --createFk --createFkIdx --createEnumTabs --beautifyEnumDispName --createMetaInfo --createNumChecks --nameByTopic --strokeArcs \
--createscript agi_mopublic_20190424.sql
```

### SO_AGI_Grundbuchplan
Beinhaltet vier spezielle Klassen, die zur Darstellung des Planes für das Grundbuch notwendig sind.

DDL-erzeugen:
```
ILI2PG_PATH=/Users/stefan/apps/ili2pg-4.3.0/ili2pg-4.3.0.jar  
java -jar ${ILI2PG_PATH} \
--dbschema agi_grundbuchplan_pub --models SO_AGI_Grundbuchplan_20190930 --modeldir ".;http://models.geo.admin.ch" \
--defaultSrsCode 2056 --createGeomIdx --createFk --createFkIdx --createEnumTabs --beautifyEnumDispName --createMetaInfo --createNumChecks --nameByTopic --strokeArcs \
--createscript agi_grundbuchplan_20190930.sql
```


## Gretljobs
Hochfahren der Entwicklungs-Edit- und Pub-DB:

```
docker-compose up
```

Env-Variablen passend zur Entwicklungsumgebung setzen:
```
export ORG_GRADLE_PROJECT_dbUriEdit="jdbc:postgresql://edit-db/edit"
export ORG_GRADLE_PROJECT_dbUserEdit="gretl"
export ORG_GRADLE_PROJECT_dbPwdEdit="gretl"
export ORG_GRADLE_PROJECT_dbUriPub="jdbc:postgresql://pub-db/pub"
export ORG_GRADLE_PROJECT_dbUserPub="gretl"
export ORG_GRADLE_PROJECT_dbPwdPub="gretl"
```

```
export ORG_GRADLE_PROJECT_dbUriEdit="jdbc:postgresql://geodb.rootso.org/edit"
export ORG_GRADLE_PROJECT_dbUserEdit="YYYYYYY"
export ORG_GRADLE_PROJECT_dbPwdEdit="XXXXXXX"
export ORG_GRADLE_PROJECT_dbUriPub="jdbc:postgresql://pub-db/pub"
export ORG_GRADLE_PROJECT_dbUserPub="gretl"
export ORG_GRADLE_PROJECT_dbPwdPub="gretl"
```

### agi_mopublic
Der GRETL-Job im dev-Ordner dient zum Herstellen der Entwicklungsumgebung. Dazu gehören insbesondere verschiedene Imports von Daten (DM01, PLZ/Ortschaft, Administrative Einteilungen).

Initialisieren der Edit-DB (alle Tasks der folgenden Subkapitel zusammen):
```
./start-gretl.sh --docker-image sogis/gretl-runtime:latest --docker-network av_import_export_ng_avimportexport --job-directory $(pwd)/gretljobs/agi_mopublic_pub/dev/ -b build-dev.gradle createSchemaCadastralSurveying replaceLandUsePlansData_2407 createSchemaPlzOrtschaft importPlzOrtschaftData createSchemaAdminEinteilung importAdminEinteilung
```

Initialisieren der Pub-DB (erzeugen des neuen MOpublic-Schemas):
```
./start-gretl.sh --docker-image sogis/gretl-runtime:latest --docker-network av_import_export_ng_avimportexport --job-directory $(pwd)/gretljobs/agi_mopublic_pub/dev/ -b build-dev.gradle createSchemaMOpublic
```

Ausführen des eigentlichen Umbau-Jobs:
```
./start-gretl.sh --docker-image sogis/gretl-runtime:latest --docker-network av_import_export_ng_avimportexport --job-directory $(pwd)/gretljobs/agi_mopublic_pub/ -b build.gradle transferAgiMopublic
```


#### AV-Schema anlegen und importieren
```
./start-gretl.sh --docker-image sogis/gretl-runtime:latest --docker-network av_import_export_ng_avimportexport --job-directory $(pwd)/gretljobs/agi_mopublic_pub/dev/ -b build-dev.gradle createSchemaCadastralSurveying replaceLandUsePlansData_2407

```

#### PLZ-Ortschaft-Schema anlegen und Daten importieren
DDL für Schema erzeugen:
```
ILI2PG_PATH=/Users/stefan/apps/ili2pg-4.3.0/ili2pg-4.3.0.jar  
java -jar ${ILI2PG_PATH} \
--dbschema agi_plz_ortschaften --models PLZOCH1LV95D --modeldir http://models.geo.admin.ch \
--defaultSrsCode 2056 --createGeomIdx --createFk --createFkIdx --createEnumTabs --beautifyEnumDispName --createMetaInfo --createNumChecks --nameByTopic --strokeArcs \
--createscript agi_plz_ortschaften.sql
```

Schema erstellen und Daten importieren:
```
./start-gretl.sh --docker-image sogis/gretl-runtime:latest --docker-network av_import_export_ng_avimportexport --job-directory $(pwd)/gretljobs/agi_mopublic_pub/dev/ -b build-dev.gradle createSchemaPlzOrtschaft importPlzOrtschaftData
```

#### Administrative Einteilungen (edit)
Daten aus (produktiver) Edit-DB exportieren:
```
ILI2PG_PATH=/Users/stefan/apps/ili2pg-3.11.3/ili2pg.jar  
java -jar ${ILI2PG_PATH} \
--dbhost geodb.verw.rootso.org --dbdatabase sogis --dbusr YYYYYYY --dbpwd XXXXXXX \
--dbschema agi_av_gb_admin_einteilung --models SO_AGI_AV_GB_Administrative_Einteilungen_20180613 \
--export administrative_einteilungen.xtf
```

DDL für Schema erzeugen:
```
ILI2PG_PATH=/Users/stefan/apps/ili2pg-4.3.0/ili2pg-4.3.0.jar  
java -jar ${ILI2PG_PATH} \
--dbschema agi_av_gb_admin_einteilung --models SO_AGI_AV_GB_Administrative_Einteilungen_20180613 \
--defaultSrsCode 2056 --createGeomIdx --createFk --createFkIdx --createEnumTabs --beautifyEnumDispName --createMetaInfo --createNumChecks --nameByTopic --strokeArcs \
--createscript agi_av_gb_admin_einteilung.sql
```

DB-Schema anlegen und Daten importieren:
```
./start-gretl.sh --docker-image sogis/gretl-runtime:latest --docker-network av_import_export_ng_avimportexport --job-directory $(pwd)/gretljobs/agi_mopublic_pub/dev/ -b build-dev.gradle createSchemaAdminEinteilung importAdminEinteilung
```

### agi_grundbuchplan

Initialisieren der Pub-DB (erzeugen des neuen Grundbuchplans-Schemas):
```
./start-gretl.sh --docker-image sogis/gretl-runtime:latest --docker-network av_import_export_ng_avimportexport --job-directory $(pwd)/gretljobs/agi_grundbuchplan_pub/dev/ -b build-dev.gradle createSchemaGrundbuchplan createSchemaAdminEinteilung importAdminEinteilung
```

Ausführen des eigentlichen Umbau-Jobs:
```
./start-gretl.sh --docker-image sogis/gretl-runtime:latest --docker-network av_import_export_ng_avimportexport --job-directory $(pwd)/gretljobs/agi_grundbuchplan_pub/ -b build.gradle transferAgiGrundbuchplan
```

#### Administrative Einteilungen (pub)

DDL für Schema erzeugen:
```
ILI2PG_PATH=/Users/stefan/apps/ili2pg-4.3.0/ili2pg-4.3.0.jar  
java -jar ${ILI2PG_PATH} \
--dbschema agi_av_gb_admin_einteilung_pub --models SO_AGI_AV_GB_Administrative_Einteilungen_Publikation_20180822 \
--defaultSrsCode 2056 --createGeomIdx --createFk --createFkIdx --createEnumTabs --beautifyEnumDispName --createMetaInfo --createNumChecks --nameByTopic --strokeArcs \
--createscript agi_av_gb_admin_einteilung_pub.sql
```
