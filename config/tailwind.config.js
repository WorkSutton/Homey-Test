const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}',
    './config/initializers/simple_form.rb',
    './gems/ruby/3.2.0/gems/simple_form_tailwind_css-1.0.0/lib/simple_form/**/*.rb',
    './lib/simple_form/tailwind/**/*.rb',
    `${process.env.SIMPLE_FORM_TAILWIND_DIR}/**/*.rb`,
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
      },
      colors: {
        // "flash-info": "hsla(196, 93%, 60%, 1)",
        // "flash-warn": "hsla(43, 96%, 56%, 1)",
        // "flash-success": "hsla(158, 64%, 52%, 1)",
        // "flash-error": "hsla(0, 91%, 71%, 1)",
        // "flash-alert": "hsla(0, 91%, 71%, 1)",
        // "flash-notice": "hsla(158, 64%, 52%, 1)",
        "flash-info": {
          50: "#EBF9FE",
          100: "#D8F3FE",
          200: "#B0E8FC",
          300: "#89DCFB",
          400: "#61D1F9",
          DEFAULT: "#3AC5F8",
          600: "#08B0EC",
          700: "#0684B1",
          800: "#045876",
          900: "#022C3B",
          950: "#01161E"
        },
        "flash-success": {
          50: "#EAFAF4",
          100: "#D5F6EA",
          200: "#B0EED7",
          300: "#86E4C2",
          400: "#60DCAF",
          DEFAULT: "#37D39B",
          600: "#27B07D",
          700: "#1D825D",
          800: "#13583F",
          900: "#092A1E",
          950: "#05150F"
        },
        "flash-notice": {
          50: "#EAFAF4",
          100: "#D5F6EA",
          200: "#B0EED7",
          300: "#86E4C2",
          400: "#60DCAF",
          DEFAULT: "#37D39B",
          600: "#27B07D",
          700: "#1D825D",
          800: "#13583F",
          900: "#092A1E",
          950: "#05150F"
        },
        "flash-warn": {
          50: "#FFF9EB",
          100: "#FEF2D2",
          200: "#FDE4A5",
          300: "#FCD778",
          400: "#FBCB50",
          DEFAULT: "#FABD22",
          600: "#E0A205",
          700: "#A57704",
          800: "#6E4F02",
          900: "#372801",
          950: "#1E1601"
        },
        "flash-alert": {
          50: "#FEF0F0",
          100: "#FEE2E2",
          200: "#FCC5C5",
          300: "#FBACAC",
          400: "#F98F8F",
          DEFAULT: "#F87272",
          600: "#F52E2E",
          700: "#D10A0A",
          800: "#880707",
          900: "#440303",
          950: "#220202"
        },
        "flash-error": {
          50: "#FEF0F0",
          100: "#FEE2E2",
          200: "#FCC5C5",
          300: "#FBACAC",
          400: "#F98F8F",
          DEFAULT: "#F87272",
          600: "#F52E2E",
          700: "#D10A0A",
          800: "#880707",
          900: "#440303",
          950: "#220202"
        },
      }
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/container-queries'),
  ],
  safelist: [
    'bg-flash-info',
    'bg-flash-warn',
    'bg-flash-success',
    'bg-flash-error',
    'bg-flash-alert',
    'bg-flash-notice',
    'text-flash-alert-500',
    'hover:bg-flash-alert-600',
    'hover:bg-flash-error-600',
    'hover:bg-flash-info-700',
    'hover:bg-flash-warn-600',
    'hover:bg-flash-warn-700',
    'hover:bg-flash-warn-800',
    'hover:bg-flash-success-600',
    'hover:bg-flash-success-700',
    'hover:bg-flash-notice-600',
    'hover:bg-flash-notice-700',
    'hover:text-black',
    'bg-flash-alert-100',
    'bg-flash-alert-300',
    'bg-flash-alert-400',
    'bg-flash-info-300',
    'bg-flash-info-400',
    'bg-flash-warn-300',
    'bg-flash-warn-400',
    'bg-flash-success-300',
    'bg-flash-success-400',
    'bg-flash-error-300',
    'bg-flash-error-400',
    'bg-flash-notice-300',
    'bg-flash-notice-400',
  ]
}
