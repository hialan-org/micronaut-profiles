./mvnw package
java -cp target/@app.name@-*.jar io.micronaut.graal.reflect.GraalClassLoadingAnalyzer
native-image --no-server \
             --class-path target/@app.name@-*.jar \
             -H:ReflectionConfigurationFiles=target/reflect.json \
             -H:EnableURLProtocols=http \
             -H:IncludeResources="logback.xml|application.yml" \
             -H:Name=@app.name@ \
             -H:Class=@defaultPackage@.Application \
             -H:+ReportUnsupportedElementsAtRuntime \
             -H:+AllowVMInspection \
             --allow-incomplete-classpath \
             --rerun-class-initialization-at-runtime='sun.security.jca.JCAUtil$CachedSecureRandomHolder,javax.net.ssl.SSLContext' \
             --delay-class-initialization-to-runtime=io.netty.handler.codec.http.HttpObjectEncoder,io.netty.handler.codec.http.websocketx.WebSocket00FrameEncoder,io.netty.handler.ssl.util.ThreadLocalInsecureRandom,com.sun.jndi.dns.DnsClient
