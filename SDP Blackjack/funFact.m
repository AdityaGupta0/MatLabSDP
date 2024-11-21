function [message] = funFact()
    i = randi([1,20]);
    switch i
        case 1
            message = 'The Eiffel Tower expands and contracts. In summer, it can grow up to 6 inches due to the thermal expansion of iron.';
        case 2
            message = 'The International Space Station (ISS) travels at 28,000 kilometers per hour (17,500 mph) and orbits the Earth every 90 minutes.';
        case 3
            message = 'The Golden Gate Bridge cables are long enough to encircle the Earth more than three times if unraveled.';
        case 4
            message = 'Concrete is the second-most-used substance on Earth, after water.';            
        case 5
            message = 'The world''s first programmable computer, the Zuse Z3, was created by German engineer Konrad Zuse in 1941.';
        case 6
            message = 'The Hoover Dam is so massive that it could cover the entire state of Delaware in 1 foot of water.';
        case 7
            message = 'Lego bricks are manufactured with such accuracy that only 18 out of every million pieces fail to meet quality standards.';
        case 8
            message = 'The Large Hadron Collider (LHC) near Geneva is the largest and most powerful particle accelerator ever built, requiring 27 kilometers (17 miles) of circular tunnels.';
        case 9
            message = 'Biomimicry in engineering inspired velcro, modeled after the way burrs stick to fabric.';
        case 10
            message = 'The ISS (International Space Station) is the most expensive structure ever built, costing over $150 billion.';
        case 11
            message = 'The Mars rovers Opportunity and Spirit were designed to last 90 days but exceeded expectations. Opportunity worked for nearly 15 years!';
        case 12
            message = 'The largest wind turbine in the world, the Haliade-X, has blades longer than a football field and can power thousands of homes.';
        case 13
            message = 'Maglev trains use magnetic levitation to achieve speeds of over 600 km/h (373 mph) without physical contact with the tracks.';
        case 14
            message = 'Water jet cutters, used in industrial applications, can slice through steel with a stream of water at pressures over 60,000 psi.';
        case 15
            message = 'The Millau Viaduct in France, taller than the Eiffel Tower, is the highest road bridge in the world, spanning the Tarn Valley.';
        case 16
            message = 'The Deep Sea Challenger, a submersible used by filmmaker James Cameron, can dive to depths of nearly 11 kilometers (7 miles).';
        case 17
            message = 'Antarctica''s Halley VI Research Station is built on skis, allowing it to be moved to avoid being buried by snow.';
        case 18
            message = 'The Mars Perseverance Rover is powered by a plutonium-powered generator that can last for decades in extreme conditions.';
        case 19
            message = 'Self-healing concrete is an emerging technology that uses bacteria to repair cracks, extending the lifespan of structures.';
        case 20
            message = 'The Hoover Tower clocks at Stanford University are so accurate they only drift by one second every 300 years.';
    end
end