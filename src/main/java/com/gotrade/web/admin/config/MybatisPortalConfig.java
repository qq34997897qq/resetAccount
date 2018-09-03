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
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;

@Configuration
@MapperScan(basePackages = { "com.gotrade.web.admin.dao.portal" }, sqlSessionFactoryRef = "portalSqlSessionFactory")
public class MybatisPortalConfig {
	
	@Value("${mybatis.portal.mapperLocations}")
	private String mapperLocation;
	
	@Autowired
	@Qualifier("portal")
	private DataSource dataSource;

	@Bean(name = "portalSqlSessionFactory")
	public SqlSessionFactory getSqlSessionFactory() throws Exception {
		SqlSessionFactoryBean factoryBean = new SqlSessionFactoryBean();
		factoryBean.setDataSource(dataSource);
		factoryBean.setMapperLocations(new PathMatchingResourcePatternResolver().getResources(mapperLocation));
		return factoryBean.getObject();

	}

	@Bean(name = "portalSqlSessionFactory")
	public SqlSessionTemplate getSqlSessionTemplate() throws Exception {
		SqlSessionTemplate template = new SqlSessionTemplate(getSqlSessionFactory()); // 使用上面配置的Factory
		return template;
	}
	
	@Bean(name = "portalTransactionManager")
    public DataSourceTransactionManager transactionManager() {
        return new DataSourceTransactionManager(dataSource);
    }
}
