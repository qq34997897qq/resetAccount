package com.gotrade.web.admin.config;

import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;

@Configuration
@MapperScan(basePackages = { "com.gotrade.web.admin.dao.broker" }, sqlSessionFactoryRef = "brokerSqlSessionFactory")
public class MybatisBrokerConfig {
	
	@Value("${mybatis.broker.mapperLocations}")
	private String mapperLocation;
	
	@Autowired
	@Qualifier("broker")
	private DataSource dataSource;

	@Bean(name = "brokerSqlSessionFactory")
	@Primary
	public SqlSessionFactory getSqlSessionFactory() throws Exception {
		SqlSessionFactoryBean factoryBean = new SqlSessionFactoryBean();
		factoryBean.setDataSource(dataSource);
		factoryBean.setMapperLocations(new PathMatchingResourcePatternResolver().getResources(mapperLocation));
		return factoryBean.getObject();

	}

	@Bean(name = "brokerSqlSessionFactory")
	@Primary
	public SqlSessionTemplate getSqlSessionTemplate() throws Exception {
		SqlSessionTemplate template = new SqlSessionTemplate(getSqlSessionFactory()); // 使用上面配置的Factory
		return template;
	}
	
	@Bean(name = "brokerTransactionManager")
    @Primary
    public DataSourceTransactionManager transactionManager() {
        return new DataSourceTransactionManager(dataSource);
    }

}
