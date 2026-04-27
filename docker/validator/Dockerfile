# FHIR IG Validator - Multi-arch (amd64 + arm64)
# Based on: https://github.com/hapifhir/org.hl7.fhir.validator-wrapper
FROM eclipse-temurin:17-jre-alpine

ARG VALIDATOR_VERSION=1.0.75

ENV APPLICATION_USER=ktor
RUN adduser -D -g '' $APPLICATION_USER && \
    mkdir /app && chown -R $APPLICATION_USER /app && \
    mkdir -p /home/$APPLICATION_USER/.fhir/packages && \
    chown -R $APPLICATION_USER /home/$APPLICATION_USER/.fhir

ADD --chown=$APPLICATION_USER \
    https://github.com/hapifhir/org.hl7.fhir.validator-wrapper/releases/download/${VALIDATOR_VERSION}/validator-wrapper.jar \
    /app/validator-wrapper.jar

USER $APPLICATION_USER
WORKDIR /app

ENV ENVIRONMENT=prod
EXPOSE 3500

CMD ["java", "-server", \
     "-XX:InitialRAMPercentage=79", "-XX:MinRAMPercentage=79", "-XX:MaxRAMPercentage=79", \
     "-XX:+UseG1GC", "-XX:MaxGCPauseMillis=100", "-XX:+UseStringDeduplication", \
     "-XX:+CrashOnOutOfMemoryError", \
     "-jar", "validator-wrapper.jar", "-startServer"]
