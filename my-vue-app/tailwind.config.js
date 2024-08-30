/** @type {import('tailwindcss').Config} */
export default {
  content: ["./index.html",
    "./src/**/*.{js,ts,jsx,tsx}",],
  theme: {
    extend: {
      colors: {
        'custom-purple': '#6448AF', // Add custom color
        'custom-purple-accent': '#AD9CD5', // Add custom color
      },
    },
  },
  plugins: [],
}

