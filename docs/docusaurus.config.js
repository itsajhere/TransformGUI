module.exports = {
  title: 'Transform GUI',
  tagline: 'A ROBLOX module to create draggable and resizeable guis easily',
  url: 'https://itsajhere.github.io/TransformGUI/',
  baseUrl: '/TransformGUI/',
  onBrokenLinks: 'throw',
  onBrokenMarkdownLinks: 'warn',
  favicon: 'img/favicon.ico',
  organizationName: 'itsajhere', // Usually your GitHub org/user name.
  projectName: 'TransformGui', // Usually your repo name.
  themeConfig: {
    colorMode: {
      defaultMode: "dark"
    },
    navbar: {
      title: 'Transform Gui',
      items: [
        {
          to: 'docs/',
          activeBasePath: 'docs',
          label: 'Docs',
          position: 'left',
        },
        {
          href: 'https://github.com/itsajhere/transformgui',
          label: 'GitHub',
          position: 'right',
        },
      ],
    },
    footer: {
      style: 'dark',
      copyright: `Copyright © ${new Date().getFullYear()} itsajhere.`,
    },
  },
  presets: [
    [
      '@docusaurus/preset-classic',
      {
        docs: {
          sidebarPath: require.resolve("./sidebars.js").mySidebar
        },
        theme: {
          customCss: require.resolve('./src/css/custom.css'),
        },
      },
    ],
  ],
};
