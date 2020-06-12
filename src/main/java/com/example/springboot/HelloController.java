package com.example.springboot;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.client.RestTemplate;

import javax.servlet.http.HttpServletRequest;

@RestController
public class HelloController {

    @RequestMapping("/hello")
    public String index() {
        return "Greetings from Spring Boot!";
    }

    @RequestMapping("/envoy/egress/{service}")
    public String envoy(@PathVariable String service) {
        RestTemplate restTemplate = new RestTemplate();
        String fooResourceUrl
                  //= "http://springboot-service-2:8090/service2/hello"; -- Direct Service Call
                  = "http://localhost:9000/"+service+"/client"; //-- Through Envoy Egress
        ResponseEntity<String> response
                = restTemplate.getForEntity(fooResourceUrl , String.class);
        return response.getBody() + " , Call goes through  <BR> fooResourceUrl : " + fooResourceUrl;
    }

    @RequestMapping("/client")
    public String getClientData(HttpServletRequest request) {
        return "Inside Client method . Host : " + request.getRemoteHost()
                +" , Port : " + request.getRemotePort()
                +" , Context Path : " + request.getContextPath();
    }
}