/*
 * ESP_SWITCH: Software per nodo ESP01 per MSH.
 * Espone API per lanciare CMD + Home Page con comandi
 * Version 1.0  May, 2019
 * Authors: Davide Menozzi, Simone Sganzerla
*/

#include <ESP8266WiFi.h>
#include <WiFiClient.h>
#include <ESP8266WebServer.h>
#include <ESP8266mDNS.h>
#include <ArduinoJson.h>
#include "index.h"

#ifndef STASSID
#define STASSID ""
#define STAPSK ""
#endif

const char* ssid = STASSID;
const char* password = STAPSK;

ESP8266WebServer server(80);

DynamicJsonDocument jsonBuffer(1024);


const int GPIO0 = 0;

void handleRoot() {
  server.send(200, "text/html", file_head+file_index_body);
}

void handle_CMD() {

  String jsonOut = "";
  bool ok = false;
  bool param=false;
  jsonBuffer.clear();
  for (uint8_t i = 0; i < server.args(); i++) {
    if (server.argName(i) == "n") 
      jsonBuffer["cmd"] = server.arg(i);
      if (jsonBuffer["cmd"] == "toggle" || jsonBuffer["cmd"] == "stato")
        ok=true;
  }
  
  if (ok)
  {
    if (jsonBuffer["cmd"] == "toggle") param=true;
    delay(10);
    jsonBuffer["output"] = (CMD(param)) ? "ON" : "OFF";
  }
  else
    jsonBuffer["output"] = "ERR";    //Comando non valido
  
  serializeJson(jsonBuffer, jsonOut);
  server.send(200, " application/json", jsonOut);
}

void handleNotFound() {
  server.send(404, "text/html", file_head+file_error_body);
}

void setup(void) {
  pinMode(GPIO0, OUTPUT);
  Serial.begin(115200);
  WiFi.mode(WIFI_STA);
  WiFi.begin(ssid, password);
  Serial.println("");
    
  // Wait for connection
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  Serial.println("");
  Serial.print("Connected to ");
  Serial.println(ssid);
  Serial.print("IP address: ");
  Serial.println(WiFi.localIP());

  if (MDNS.begin("esp8266")) {
    Serial.println("MDNS responder started");
  }

  server.on("/", handleRoot);
  server.on("/cmd", handle_CMD);

  server.onNotFound(handleNotFound);

  server.begin();
  Serial.println("HTTP server started");
}

void loop(void) {
  server.handleClient();
  MDNS.update();
}


//param true significa che la funzione è stata invocata come comando
//param false significa che la funzione è stata invocata per sapere stato on/off
//
bool CMD(bool param)
{
  bool result=false;
  if (param) 
  {
    // Codice da eseguire in caso di Comando
    Serial.println("Comando");
    result=true;
  }
  else
  {
    // Codice letura stato
    Serial.println("Stato");
  }

  
  return result;
}
  
