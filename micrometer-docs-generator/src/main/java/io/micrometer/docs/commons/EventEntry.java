/*
 * Copyright 2022 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package io.micrometer.docs.commons;

import io.micrometer.observation.Observation;
import io.micrometer.tracing.docs.EventValue;

/**
 * Model object for {@link Observation.Event} and {@link EventValue}.
 *
 * @author Tadaya Tsuyukubo
 */
public class EventEntry implements Comparable<EventEntry> {

    private String value;

    private String description;

    // TODO: naming
    public String getName() {
        return this.value;
    }

    public String getDisplayDescription() {
        // TODO: use handlebar helper to compose the description
        String suffix = "";
        if (this.value.contains("%s")) {
            suffix = " (since the name contains `%s` the final value will be resolved at runtime)";
        }
        return this.description + suffix;
    }

    @Override
    public int compareTo(EventEntry other) {
        return this.value.compareTo(other.value);
    }

    public String getValue() {
        return this.value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    public String getDescription() {
        return this.description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}
