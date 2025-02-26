// import this after install `@mdi/font` package
import "@mdi/font/css/materialdesignicons.css";

import "vuetify/styles";
import { createVuetify } from "vuetify";
import * as components from "vuetify/components";
import * as directives from "vuetify/directives";

const vuetify = createVuetify({
    components,
    directives,
    theme: {
        themes: {
            light: {
                dark: false,
                colors: {
                    primary: "#FF6F61",
                    secondary: "#424242",
                    accent: "#FFD166",
                    error: "#EF476F",
                    info: "#4A4A4A",
                    success: "#06D6A0",
                    warning: "#118AB2",
                    background: "#F4F4F4"
                }
            }
        }
    }
});

export default vuetify;
