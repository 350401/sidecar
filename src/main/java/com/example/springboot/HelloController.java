package com.example.springboot;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.client.RestTemplate;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

@RestController
public class HelloController {

    @RequestMapping("/health")
    public String index() {
        return "Greetings from Spring Boot!";
    }

    @RequestMapping("/envoy/egress/{service}")
    public String envoy(@PathVariable String service, @RequestHeader Map<String, String> headers) {
        RestTemplate restTemplate = new RestTemplate();

        //Set the headers you need send
        final HttpHeaders reqHeaders = new HttpHeaders();
        headers.forEach((key, value) -> {
            if(key.startsWith("x-")){
                reqHeaders.add(key,value);
            }
        });

        //Create a new HttpEntity
        final HttpEntity<String> entity = new HttpEntity<String>(reqHeaders);

        String fooResourceUrl
                  //= "http://springboot-service-2:8090/service2/hello"; -- Direct Service Call
                  = "http://localhost:9000/"+service+"/client"; //-- Through Envoy Egress

        //Execute the method writing your HttpEntity to the request
        ResponseEntity<String> response = restTemplate.exchange(fooResourceUrl, HttpMethod.GET, entity, String.class);
        System.out.println(response.getBody());

/*        ResponseEntity<String> response
                = restTemplate.getForEntity(fooResourceUrl , String.class);*/

        return response.getBody() + " , Call goes through  <BR> fooResourceUrl : " + fooResourceUrl;
    }

    @RequestMapping("/client")
    public String getClientData(HttpServletRequest request, @RequestHeader Map<String, String> headers) {

        StringBuilder stringBuilder = new StringBuilder();
        headers.forEach((key, value) -> {
            stringBuilder.append(String.format("Header '%s' = %s <BR> ", key, value));
        });

        return "Inside Client method . Host : " + request.getRemoteHost()
                +" , Port : " + request.getRemotePort()
                +" , Headers : <BR> " + stringBuilder.toString()
                +" , Context Path : " + request.getContextPath();
    }
}