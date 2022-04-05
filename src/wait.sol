// SPDX-License-Identifier: AGPL-3.0
pragma solidity ^0.8.0;

import "base64-sol/base64.sol";

contract WAIT {
    mapping(bytes4 => bool) internal supportedInterfaces;

    function name() public pure returns (string memory) {
        return "CARRE";
    }

    function symbol() public pure returns (string memory) {
        return "ROND";
    }

    function totalSupply() public pure returns (uint256) {
        return 2;
    }

    function genSLSVG() public pure returns (string memory) {
        return
            '<?xml version=\\"1.0\\" encoding=\\"iso-8859-1\\"?><svg version=\\"1.1\\" id=\\"Layer_1\\" xmlns=\\"http://www.w3.org/2000/svg\\" xmlns:xlink=\\"http://www.w3.org/1999/xlink\\" x=\\"0px\\" y=\\"0px\\"  width=\\"4170.252px\\" height=\\"2926.944px\\" viewBox=\\"0 0 4170.252 2926.944\\" enable-background=\\"new 0 0 4170.252 2926.944\\"  xml:space=\\"preserve\\"><rect x=\\"0.5\\" y=\\"0.5\\" stroke=\\"#000000\\" stroke-miterlimit=\\"10\\" width=\\"4169.252\\" height=\\"2925.944\\"/><g> <path fill=\\"#F2F2F2\\" d=\\"M2098.066,902.925c25.612-9.897,31.319-15.604,65.622-23.743c-6.965-22.74-11.237-45.723-13.205-68.795  v0.001c-5.066-48.315,7.045-136.909,26.885-184.043c0.002,0.001,123.838-159.391,123.838-159.391s-85.678,94.286-142.332,152.527  c-15.249,15.677-34.919,25.839-56.113,29.035C2101.834,655.521,2105.625,807.509,2098.066,902.925z\\"/> <path fill=\\"#F2F2F2\\" d=\\"M2183.789,880.662c-33.114,27.288-51.345,53.5-89.266,51.15c-45.835-44.048-9.002-266.385-11.656-283.466  c-50.928-22.756-30.017-295.043-28.313-329.653c-11.221,91.294-33.038,556.061-51.592,587.829  c0.701,0.061,81.263-64.492,76.946,364.648C2089.071,1024.883,2064.66,1024.253,2183.789,880.662z\\"/> <path fill=\\"#F2F2F2\\" d=\\"M2298.388,958.664c16.924-17.399,38.755-28.678,62.277-32.224c-2.27-11.521-4.034-69.547-4.321-74.21  c0.554-101.625,2.335-113.858,10.238-217.901c-1.451-31.524,140.964-194.217,157.526-220.802c0,0-97.74,107.56-162.369,174  c-17.396,17.884-39.834,29.477-64.012,33.122c0.678,6.523,2.075,21.283,3.663,38.603c-11.777-6.666-33.506-17.339-92.34-63.861  c25.945,31.141,26.851,97.604-35.928,97.128c8.948,53.448,5.527,108.448-2.854,161.802c41.954,12.802,48.076,23.256,69.796,60.353  c11.097-37.81,34.592-38.173,60.708-46.907c-4.379,36.85-11.901,69.106-22.911,83.278l-137.439,176.901  C2140.421,1127.946,2235.511,1023.303,2298.388,958.664z M2235.9,692.995c38.642-0.341,60.376,34.117,66.334,66.413  c1.976,11.185-0.515,99.849-0.599,100.643C2199.265,860.05,2225.834,758.909,2235.9,692.995z\\"/> <path fill=\\"#F2F2F2\\" d=\\"M1998.703,658.396c-27.485-4.144-49.374-17.323-69.149-37.653  c-73.469-75.529-184.579-197.802-184.579-197.802c19.694,31.896,180.556,213.61,178.357,251.258  c12.875,48.614,7.021,108.971,6.248,155.761c-0.987,8.966-2.126,17.715-3.419,26.111c-61.678-4.917-67.237-45.969-64.221-103.259  c1.903-32.071,6.516-127.755,6.974-132.164c-24.177-3.645-46.616-15.238-64.012-33.122c-64.629-66.44-162.369-174-162.369-174  l141.269,181.83c12.341,15.884,20.421,53.869,24.694,95.981c0.079,0.009,0.159,0.019,0.238,0.028  c7.098,72.643,3.274,157.565-9.29,162.599c34.661,10.002,40.408,16.243,62.913,52.149c1.474-11.476,25.682-36.383,62.437-41.644  c-5.037,29.318-12.096,53.424-21.339,65.774l-154.7,206.703c0,0,107.033-122.273,177.807-197.802  c19.05-20.33,38.193-33.509,64.67-37.653C1987.558,761.763,1993.266,712.538,1998.703,658.396z\\"/> <path fill=\\"#F2F2F2\\" d=\\"M1731.348,956.736c17.396-17.883,39.834-29.477,64.012-33.122c-4.609-44.349-7.648-96.28-8.059-147.083  l-23.745-27.053l23.978-12.246c0.314-26.53,2.587-56.553,4.529-79.978c-54.653,49.513-80.893-92.274-87.998-117.382  c-0.234,24.143,22.574,195.693,22.574,195.695c0,0-69.821-20.72-72.564-80.386c-3.403-74.035-48.586-280.564-48.789-280.596  c1.807,36.276,27.088,228.238-11.879,240.609c-172.492-139.437-363.293-412.482-363.294-412.483l170.11,254.342  c190.037,263.198-119.865,12.666-119.86,12.672c-0.002-0.002,211.3,232.776,63.427,211.973  c40.583,12.456,92.358,26.596,126.53,52.771c18.623,12.809,31.883,32.697,36.356,55.487  c18.743,95.495-160.803-40.636-160.805-40.637c-0.925,0.011,141.378,149.206,285.952,300.531l-62.843,80.886  c0,0,30.499-33.563,68.686-74.77c146.855,153.705,294.094,307.563,294.094,307.563l-277.261-325.684  C1680.324,1010.115,1707.997,980.742,1731.348,956.736z M1520.182,642.073c13.444,18.635,21.317,54.799,22.358,77.388  c5.239-18.854,11.231-82.125,52.154-71.029c3.469,31.233,17.005,115.033,18.088,146.5  c-84.182-34.243-230.979-165.34-123.691-191.769v0C1478.716,591.482,1502.42,617.453,1520.182,642.073z M1592.892,965.477  c-67.487-89.077-31.661-130.068-31.661-130.067c42.343,23.985,117.041,63.677,124.362,105.256l-22.451-207.792  c38.477-9.303,79.093,35.333,79.523,112.246c6.593,66.447-57.711,136.857-95.145,184.525L1592.892,965.477z\\"/> <path fill=\\"#F2F2F2\\" d=\\"M2515.753,1037.844l-277.26,325.684c0,0,147.239-153.858,294.094-307.563  c38.187,41.207,68.686,74.77,68.686,74.77l-62.843-80.886c144.574-151.325,286.877-300.52,285.952-300.531  c-0.002,0.001-179.548,136.132-160.805,40.637c4.473-22.79,17.733-42.677,36.355-55.488c34.018-26.109,86.136-40.405,126.53-52.77  c-147.873,20.802,63.429-211.976,63.427-211.973c0.005-0.006-309.897,250.526-119.86-12.672l170.11-254.342  c-0.001,0.001-190.802,273.046-363.294,412.483c-38.966-12.371-13.686-204.333-11.879-240.609  c-0.203,0.031-45.386,206.561-48.789,280.596c-2.743,59.665-72.564,80.386-72.564,80.386c0-0.001,22.808-171.552,22.574-195.695  c-7.105,25.108-33.345,166.894-87.998,117.382c8.01,83.528,5.165,185.474-3.298,266.36  C2438.432,934.273,2469.65,994.955,2515.753,1037.844z M2681.174,603.162L2681.174,603.162  c107.246,26.475-39.443,157.464-123.691,191.77c1.083-31.467,14.619-115.267,18.088-146.5  c40.923-11.096,46.915,52.175,52.154,71.029C2627.213,662.937,2667.425,617.417,2681.174,603.162z M2522.747,1029.646  c-37.539-47.923-101.656-117.891-95.144-184.529c0.243-76.612,41.356-121.797,79.522-112.242l-22.451,207.792  c7.343-41.601,82.003-81.255,124.362-105.256C2643.456,876.892,2585.466,964.525,2522.747,1029.646z\\"/></g><rect x=\\"0.25\\" y=\\"1521.164\\" fill=\\"#F2F2F2\\" width=\\"4169.752\\" height=\\"1405.78\\"/><g> <path stroke=\\"#000000\\" stroke-miterlimit=\\"10\\" d=\\"M2098.066,2272.976c25.612-9.897,31.319-15.604,65.622-23.743  c-6.965-22.74-11.237-45.723-13.205-68.795v0.001c-5.066-48.315,7.045-136.909,26.885-184.043  c0.002,0.001,123.838-159.391,123.838-159.391s-85.678,94.286-142.332,152.527c-15.249,15.677-34.919,25.839-56.113,29.035  C2101.834,2025.572,2105.625,2177.559,2098.066,2272.976z\\"/> <path stroke=\\"#000000\\" stroke-miterlimit=\\"10\\" d=\\"M2183.789,2250.713c-33.114,27.288-51.345,53.5-89.266,51.15  c-45.835-44.048-9.002-266.385-11.656-283.466c-50.928-22.756-30.017-295.043-28.313-329.653  c-11.221,91.294-33.038,556.061-51.592,587.829c0.701,0.061,81.263-64.492,76.946,364.648  C2089.071,2394.933,2064.66,2394.304,2183.789,2250.713z\\"/> <path stroke=\\"#000000\\" stroke-miterlimit=\\"10\\" d=\\"M2298.388,2328.714c16.924-17.399,38.755-28.678,62.277-32.224  c-2.27-11.521-4.034-69.547-4.321-74.21c0.554-101.625,2.335-113.858,10.238-217.901  c-1.451-31.524,140.964-194.217,157.526-220.802c0,0-97.74,107.56-162.369,174c-17.396,17.884-39.834,29.477-64.012,33.122  c0.678,6.522,2.075,21.283,3.663,38.603c-11.777-6.666-33.506-17.339-92.34-63.861c25.945,31.141,26.851,97.604-35.928,97.128  c8.948,53.448,5.527,108.448-2.854,161.802c41.954,12.802,48.076,23.256,69.796,60.353c11.097-37.81,34.592-38.173,60.708-46.907  c-4.379,36.85-11.901,69.106-22.911,83.278l-137.439,176.901C2140.421,2497.997,2235.511,2393.353,2298.388,2328.714z   M2235.9,2063.045c38.642-0.341,60.376,34.117,66.334,66.413c1.976,11.185-0.515,99.849-0.599,100.643  C2199.265,2230.101,2225.834,2128.96,2235.9,2063.045z\\"/> <path stroke=\\"#000000\\" stroke-miterlimit=\\"10\\" d=\\"M1998.703,2028.447c-27.485-4.144-49.374-17.323-69.149-37.653  c-73.469-75.529-184.579-197.802-184.579-197.802c19.694,31.896,180.556,213.61,178.357,251.258  c12.875,48.614,7.021,108.971,6.248,155.761c-0.987,8.966-2.126,17.715-3.419,26.111c-61.678-4.917-67.237-45.969-64.221-103.259  c1.903-32.071,6.516-127.755,6.974-132.164c-24.177-3.645-46.616-15.239-64.012-33.122c-64.629-66.44-162.369-174-162.369-174  l141.269,181.83c12.341,15.884,20.421,53.869,24.694,95.981c0.079,0.009,0.159,0.019,0.238,0.028  c7.098,72.643,3.274,157.565-9.29,162.599c34.661,10.002,40.408,16.243,62.913,52.149c1.474-11.476,25.682-36.384,62.437-41.644  c-5.037,29.318-12.096,53.424-21.339,65.773l-154.7,206.703c0,0,107.033-122.273,177.807-197.802  c19.05-20.33,38.193-33.509,64.67-37.653C1987.558,2131.813,1993.266,2082.589,1998.703,2028.447z\\"/> <path stroke=\\"#000000\\" stroke-miterlimit=\\"10\\" d=\\"M1731.348,2326.786c17.396-17.883,39.834-29.477,64.012-33.122  c-4.609-44.349-7.648-96.28-8.059-147.083l-23.745-27.053l23.978-12.246c0.314-26.53,2.587-56.553,4.529-79.978  c-54.653,49.513-80.893-92.274-87.998-117.381c-0.234,24.143,22.574,195.693,22.574,195.695c0,0-69.821-20.72-72.564-80.386  c-3.403-74.035-48.586-280.564-48.789-280.596c1.807,36.276,27.088,228.238-11.879,240.609  c-172.492-139.437-363.293-412.482-363.294-412.483l170.11,254.342c190.037,263.198-119.865,12.666-119.86,12.672  c-0.002-0.002,211.3,232.776,63.427,211.973c40.583,12.457,92.358,26.596,126.53,52.771c18.623,12.809,31.883,32.697,36.356,55.487  c18.743,95.495-160.803-40.636-160.805-40.637c-0.925,0.011,141.378,149.206,285.952,300.531l-62.843,80.886  c0,0,30.499-33.563,68.686-74.771c146.855,153.705,294.094,307.563,294.094,307.563l-277.261-325.684  C1680.324,2380.166,1707.997,2350.792,1731.348,2326.786z M1520.182,2012.124c13.444,18.635,21.317,54.799,22.358,77.388  c5.239-18.854,11.231-82.125,52.154-71.029c3.469,31.233,17.005,115.033,18.088,146.5  c-84.182-34.243-230.979-165.34-123.691-191.769v0C1478.716,1961.533,1502.42,1987.504,1520.182,2012.124z M1592.892,2335.528  c-67.487-89.077-31.661-130.068-31.661-130.067c42.343,23.985,117.041,63.677,124.362,105.256l-22.451-207.792  c38.477-9.303,79.093,35.333,79.523,112.246c6.593,66.447-57.711,136.857-95.145,184.525L1592.892,2335.528z\\"/> <path stroke=\\"#000000\\" stroke-miterlimit=\\"10\\" d=\\"M2515.753,2407.895l-277.26,325.684c0,0,147.239-153.858,294.094-307.563  c38.187,41.207,68.686,74.771,68.686,74.771l-62.843-80.886c144.574-151.324,286.877-300.52,285.952-300.531  c-0.002,0.001-179.548,136.132-160.805,40.637c4.473-22.79,17.733-42.677,36.355-55.488c34.018-26.109,86.136-40.405,126.53-52.77  c-147.873,20.802,63.429-211.976,63.427-211.973c0.005-0.006-309.897,250.526-119.86-12.672l170.11-254.342  c-0.001,0.001-190.802,273.046-363.294,412.483c-38.966-12.371-13.686-204.333-11.879-240.609  c-0.203,0.031-45.386,206.561-48.789,280.596c-2.743,59.665-72.564,80.386-72.564,80.386c0-0.001,22.808-171.552,22.574-195.695  c-7.105,25.108-33.345,166.894-87.998,117.381c8.01,83.528,5.165,185.474-3.298,266.36  C2438.432,2304.324,2469.65,2365.005,2515.753,2407.895z M2681.174,1973.213L2681.174,1973.213  c107.246,26.475-39.443,157.464-123.691,191.77c1.083-31.467,14.619-115.267,18.088-146.5  c40.923-11.096,46.915,52.175,52.154,71.029C2627.213,2032.987,2667.425,1987.468,2681.174,1973.213z M2522.747,2399.696  c-37.539-47.923-101.656-117.891-95.144-184.529c0.243-76.612,41.356-121.797,79.522-112.242l-22.451,207.792  c7.343-41.601,82.003-81.255,124.362-105.256C2643.456,2246.943,2585.466,2334.576,2522.747,2399.696z\\"/></g><g></g><g></g><g></g><g></g><g></g><g></g></svg>';
    }

    function tokenURI(uint256) public pure returns (string memory) {
        return
            string(
                abi.encodePacked(
                    "data:application/json;base64,",
                    Base64.encode(
                        bytes(
                            abi.encodePacked(
                                '{"name":"',
                                name(),
                                '", "description":"',
                                symbol(),
                                string(abi.encodePacked('", "external_url": "', "https://sky-light-sl.com/")),
                                '", "image":"',
                                string(
                                    abi.encodePacked(
                                        genSLSVG(),
                                        '", "animation_url": "ipfs://QmSFsJE2fvm9PxaUVzSAZySJqmALZLK4EtD67PBmv5wB8t/skylight-chrome-2000x2000.mp4'
                                    )
                                ),
                                '"}'
                            )
                        )
                    )
                )
            );
    }

    function supportsInterface(bytes4 interfaceID) external view returns (bool) {
        return supportedInterfaces[interfaceID];
    }

    constructor() {
        // Just to toy with stuff ;-) SL
        supportedInterfaces[0x01ffc9a7] = true; // ERC165
        supportedInterfaces[0x80ac58cd] = true; // ERC721
        supportedInterfaces[0x5b5e139f] = true; // ERC721Metadata
        supportedInterfaces[0x780e9d63] = true; // ERC721Enumerable
        supportedInterfaces[0x8153916a] = true; // ERC721 + 165 (not needed)
    }
}
