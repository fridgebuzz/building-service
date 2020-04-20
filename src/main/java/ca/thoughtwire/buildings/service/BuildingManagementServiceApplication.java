package ca.thoughtwire.buildings.service;

import com.ulisesbocchio.jasyptspringboot.annotation.EnableEncryptableProperties;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.properties.EnableConfigurationProperties;

@EnableConfigurationProperties
@SpringBootApplication
@EnableEncryptableProperties
public class BuildingManagementServiceApplication
{
	public static void main(String[] args)
	{
		SpringApplication.run(BuildingManagementServiceApplication.class, args);
	}
}
