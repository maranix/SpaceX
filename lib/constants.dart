import 'package:flutter/material.dart';

String rockets = """
      {
        rockets {
          name
          id
        }
      }
    """;

String rocketData = """
    query data(\$identification: ID!){
      rocket(id: \$identification) {
        name
        mass {
          kg
        }
        landing_legs {
          material
          number
        }
        height {
          meters
        }
        first_flight
        first_stage {
          burn_time_sec
          engines
          fuel_amount_tons
          reusable
          thrust_sea_level {
            kN
          }
          thrust_vacuum {
            kN
          }
        }
        diameter {
          meters
        }
        description
        country
        cost_per_launch
        company
        boosters
        active
        payload_weights {
          kg
        }
        second_stage {
          engines
          burn_time_sec
          fuel_amount_tons
          thrust {
            kN
          }
        }
        stages
        success_rate_pct
        type
        wikipedia
      }
    }
  """;

String missions = """
  {
    missions {
      id
      name
      description
      wikipedia
      manufacturers
    }
  }
  """;

String missionsData = """
  {
    missions(find: {id: \$identification}) {
      id
      name
      description
      wikipedia
      manufacturers
    }
  }
  """;

List rocketImages = [
  "assets/images/falcon1.jpg",
  "assets/images/falcon9.jpeg",
  "assets/images/falconheavy.jpeg",
  "assets/images/starship.jpeg"
];

TextStyle h1 = TextStyle(fontSize: 30, fontWeight: FontWeight.w500);

TextStyle h2 = TextStyle(fontSize: 20, fontWeight: FontWeight.w500);

TextStyle h3 = TextStyle(fontSize: 18, fontWeight: FontWeight.w500);

TextStyle h4 = TextStyle(
  fontSize: 17,
);
