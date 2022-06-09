
export const UI_MODULES : string[] = [
    'ui-components',
    'ui-alerts',
    'ui-browser',
    'ui-rule-engine',
    'ui-time-machine',
    'ui-validator-config',
    'ui-worldvious',
    'ui-dev-tools',
    'ui-search',
    'ui-properties',
    'ui-guard',
]

export const UI_MODULE_DEPS : Record<string, string> = {
    'react': '17.0.2',
    'react-dom': '17.0.2',
    'react-router-dom': '5.3.3',

    'classnames': '2.3.1',
}

export const UI_MODULE_DEV_DEPS : Record<string, string> = {
    '@babel/core': '7.18.2',
    'babel-loader': '8.2.5',

    'postcss': '8.4.14',
    'sass': '1.52.2',
    'sass-loader': '13.0.0',
    'css-loader': '6.7.1',

    'rollup': '2.75.6',
    '@rollup/plugin-babel': '5.3.1',
    '@rollup/plugin-commonjs': '22.0.0',
    '@rollup/plugin-json': '4.1.0',
    'rollup-plugin-peer-deps-external': '2.2.4',
    'rollup-plugin-postcss': '4.0.2',
    'rollup-plugin-sass': '1.2.12',
    'rollup-plugin-typescript2': '0.32.1',

    '@storybook/addon-actions': '6.5.7',
    '@storybook/addon-essentials': '6.5.7',
    '@storybook/addon-links': '6.5.7',
    '@storybook/react': '6.5.7',
    '@storybook/preset-scss': '1.0.3',
    'storybook-css-modules-preset': '1.1.1',

    'tslib': '2.4.0',
    'typescript': '4.7.3',
    'ts-node': '10.8.1', // "^9.0.0"

    'jest': '26.6.3',
    'jest-environment-jsdom': '26.6.2',
    '@types/jest': '26.0.24', 
    'ts-jest': '26.5.6',

    '@testing-library/dom': '8.13.0',
    '@testing-library/jest-dom': '5.16.4',
    '@testing-library/react': '12.1.5',
    '@testing-library/user-event': '13.5.0',
    'should': '13.2.3',

    'eslint': '8.17.0', //  ^7.7.0
    '@typescript-eslint/eslint-plugin': '5.27.1',
    '@typescript-eslint/parser': '5.27.1',

    '@types/react': '17.0.2',
    '@types/react-dom': '17.0.2',
    '@types/react-router-dom': '5.3.3',
}

export const UI_MODULE_DEPS_DELETE : string[] = [
    'rollup-plugin-img',
    '@rollup/plugin-typescript',
    'rollup-plugin-ts',
    'rollup-plugin-babel',
    'rollup-plugin-commonjs',
    'rollup-plugin-json',

    'babel-core',
    'babel-runtime',
    '@babel/preset-env',

    'css-loader',
    '@types/classnames',
    '@types/should',
]

export const UI_MODULE_RESOLUTIONS : string[] = [
    'react',
    'react-dom',
    'react-router-dom',
    '@types/react',
    '@types/react-dom',
    '@types/react-router-dom',
]