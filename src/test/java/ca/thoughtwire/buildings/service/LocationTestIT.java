package ca.thoughtwire.buildings.service;

import ca.thoughtwire.buildings.service.application.request.LocationRequest;
import ca.thoughtwire.buildings.service.application.response.LocationResponse;
import ca.thoughtwire.buildings.service.domain.Location;
import ca.thoughtwire.buildings.service.domain.service.LocationService;
import ca.thoughtwire.buildings.service.infrastructure.configuration.BeanConfiguration;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.junit.Assert;
import org.junit.Rule;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.json.JacksonJsonParser;
import org.springframework.boot.test.autoconfigure.json.AutoConfigureJson;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.ConfigFileApplicationContextInitializer;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.converter.json.Jackson2ObjectMapperBuilder;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.testcontainers.containers.DockerComposeContainer;
import org.testcontainers.containers.output.Slf4jLogConsumer;

import java.io.File;
import java.util.Map;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@RunWith(SpringRunner.class)
@SpringBootTest(classes = BuildingManagementServiceApplication.class, webEnvironment = SpringBootTest.WebEnvironment.MOCK)
@AutoConfigureMockMvc
@ContextConfiguration(initializers = ConfigFileApplicationContextInitializer.class, classes = BeanConfiguration.class)
@ActiveProfiles("test")
public class LocationTestIT {

    @Autowired
    MockMvc mockMvc;

    @Autowired
    LocationService locationService;

    @Autowired
    private Jackson2ObjectMapperBuilder builder;

    @Test
    public void validPostReturns200() throws Exception {

        ObjectMapper objectMapper = builder.build();

       LocationRequest locationRequest = new LocationRequest("tw-admin", "DFBRO450CI");

        MvcResult mvcResult = mockMvc.perform(post("/locations")
                .contentType("application/json")
                .content(objectMapper.writeValueAsString(locationRequest)))
            .andExpect(status().isOk())
            .andReturn();

        LocationResponse expectedResponse = new LocationResponse("DFBRO450CI", "Dana-Farber Cancer Institute");
        String actualResponseBody = mvcResult.getResponse().getContentAsString();

        Assert.assertEquals(objectMapper.writeValueAsString(expectedResponse), actualResponseBody);
    }

    private static final Logger LOGGER = LoggerFactory.getLogger(LocationTestIT.class);
    private static final String COMPOSE_ENV_IDENTIFIER = "compose_container";

    @Rule
    public DockerComposeContainer composeEnv = new DockerComposeContainer(COMPOSE_ENV_IDENTIFIER,
            new File("src/test/resources/timescaledb-compose.yml"))
            .withExposedService("timescaledb", 5432)
            .withLogConsumer("timescaledb", new Slf4jLogConsumer(LOGGER));

}
