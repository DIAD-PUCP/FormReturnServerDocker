# FormReturnServerDocker
Run the server component of FormReturn on a headless Docker container

## Usage

### If you want an empty and new database

1. Build the container

    ```bash
    docker build . -t formreturn
    ```

2. Create directory to store data

    ```bash
    mkdir .formreturn
    ```

3. Run the container once to generate the configuration files and database on the previous directory

    ```bash
    docker run --rm -p 1527:1527 -v "./.formreturn:/home/formreturn/.formreturn" --name formreturn --user 1000:1000 -d formreturn_server:latest
    ```

4. Stop the container

    ```bash
    docker stop formreturn
    ```

5. Go to the configuration directory and edit the `server.xml` file, change `<allowExternalConnections>` to `true` and `listeningAddresses` to `0.0.0.0`. It should look like this:

    ```xml
    <?xml version="1.0" encoding="UTF-8"?>
    <formReturn>
    <serverPreferences>
        <version>1.7.5</version>
        <databaseServer>
        <allowExternalConnections>true</allowExternalConnections>
        <listeningAddresses>0.0.0.0</listeningAddresses>
        <portNumber>1527</portNumber>
        </databaseServer>
        <folderMonitorPreferences>
        <runWhenServerStarts>false</runWhenServerStarts>
        <interval>30</interval>
        <unprocessedImagesDirectory></unprocessedImagesDirectory>
        <processedImagesDirectory></processedImagesDirectory>
        </folderMonitorPreferences>
        <formProcessorPreferences>
        <runWhenServerStarts>true</runWhenServerStarts>
        </formProcessorPreferences>
        <taskSchedulerPreferences>
        <jobPreferences/>
        </taskSchedulerPreferences>
        <formProcessingDatabaseName>FRDB</formProcessingDatabaseName>
    </serverPreferences>
    </formReturn>
    ```

6. Run the container once again. This time it will start the server

    ```bash
    docker run --rm -p 1527:1527 -v "./.formreturn:/home/formreturn/.formreturn" --name formreturn --user 1000:1000 -d formreturn_server:latest
    ```

If you want you can change more parameters on the `server.xml` file but take note of your changes so you can configure the client later.

DO NOT EDIT the `system.password` file or your Database will be inaccesible. If you need the password to configure the client just copy it from that file

### If you have an existing database

If you have been using FormReturn on a desktop and want to reuse a database follow these steps:

1. Build the container

    ```bash
    docker build . -t formreturn
    ```

2. Go to your existing configuration directory and edit the `server.xml` file, change `<allowExternalConnections>` to `true` and `listeningAddresses` to `0.0.0.0`. It should look like this:

    ```xml
    <?xml version="1.0" encoding="UTF-8"?>
    <formReturn>
    <serverPreferences>
        <version>1.7.5</version>
        <databaseServer>
        <allowExternalConnections>true</allowExternalConnections>
        <listeningAddresses>0.0.0.0</listeningAddresses>
        <portNumber>1527</portNumber>
        </databaseServer>
        <folderMonitorPreferences>
        <runWhenServerStarts>false</runWhenServerStarts>
        <interval>30</interval>
        <unprocessedImagesDirectory></unprocessedImagesDirectory>
        <processedImagesDirectory></processedImagesDirectory>
        </folderMonitorPreferences>
        <formProcessorPreferences>
        <runWhenServerStarts>true</runWhenServerStarts>
        </formProcessorPreferences>
        <taskSchedulerPreferences>
        <jobPreferences/>
        </taskSchedulerPreferences>
        <formProcessingDatabaseName>FRDB</formProcessingDatabaseName>
    </serverPreferences>
    </formReturn>
    ```

    Again DO NOT EDIT the `system.password` file or your Database will be inaccesible. If you need the password to configure the client just copy it from that file

3. Run the container and map your existing database directory

    ```bash
    docker run --rm -p 1527:1527 -v "{YOUR DIRECTORY PATH}:/home/formreturn/.formreturn" --name formreturn --user 1000:1000 -d formreturn_server:latest
    ```
