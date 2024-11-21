<?xml version="1.0" encoding="UTF-8"?>
<!--
Copyright 2023 VMware, Inc.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

https://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
-->
<project xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
		 xmlns="http://maven.apache.org/POM/4.0.0"
		 xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 https://maven.apache.org/xsd/maven-4.0.0.xsd">
	<modelVersion>4.0.0</modelVersion>
	<groupId>com.example</groupId>
	<artifactId>micrometer-docs-generator-example</artifactId>
	<packaging>jar</packaging>
	<name>micrometer-docs-generator-example</name>
	<description>micrometer-docs-generator-example</description>
	<properties>
		<micrometer-docs-generator.version>1.0.0</micrometer-docs-generator.version>
		<micrometer-docs-generator.inputPath>${maven.multiModuleProjectDirectory}/folder-with-sources-to-scan/</micrometer-docs-generator.inputPath>
		<micrometer-docs-generator.inclusionPattern>.*</micrometer-docs-generator.inclusionPattern>
		<micrometer-docs-generator.outputPath>${maven.multiModuleProjectDirectory}/target/output-folder-with-adocs/'</micrometer-docs-generator.outputPath>
	</properties>
	<build>
		<plugins>
			<plugin>
				<groupId>org.codehaus.mojo</groupId>
				<artifactId>exec-maven-plugin</artifactId>
				<executions>
					<execution>
						<id>generate-docs</id>
						<phase>prepare-package</phase>
						<goals>
							<goal>java</goal>
						</goals>
						<configuration>
							<mainClass>io.micrometer.docs.DocsGeneratorCommand</mainClass>
							<includePluginDependencies>true</includePluginDependencies>
							<arguments>
								<argument>${micrometer-docs-generator.inputPath}</argument>
								<argument>${micrometer-docs-generator.inclusionPattern}</argument>
								<argument>${micrometer-docs-generator.outputPath}</argument>
							</arguments>
						</configuration>
					</execution>
				</executions>
				<dependencies>
					<dependency>
						<groupId>io.micrometer</groupId>
						<artifactId>micrometer-docs-generator</artifactId>
						<version>${micrometer-docs-generator.version}</version>
						<type>jar</type>
					</dependency>
				</dependencies>
			</plugin>
		</plugins>
	</build>

	<repositories>
		<repository>
			<id>spring-snapshots</id>
			<name>Spring Snapshots</name>
			<url>https://repo.spring.io/snapshot</url> <!-- For Snapshots -->
			<snapshots>
				<enabled>true</enabled>
			</snapshots>
			<releases>
				<enabled>false</enabled>
			</releases>
		</repository>
		<repository>
			<id>spring-milestones</id>
			<name>Spring Milestones</name>
			<url>https://repo.spring.io/milestone</url>  <!-- For Milestones -->
			<snapshots>
				<enabled>false</enabled>
			</snapshots>
		</repository>
	</repositories>
</project>
