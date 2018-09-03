package com.gotrade.web.admin.config;

import javax.sql.DataSource;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.boot.jdbc.DataSourceBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;

@Configuration
public class DataSourceConfig {

	@Bean(name = "broker")
	@ConfigurationProperties(prefix = "spring.datasource.broker")
	@Primary
	public DataSource brokerDataSource() {
		return DataSourceBuilder.create().build();
	}

	@Bean(name = "portal")
	@ConfigurationProperties(prefix = "spring.datasource.portal")
	public DataSource portalDataSource() {
		return DataSourceBuilder.create().build();
	}
}
