import { Link } from 'react-router-dom'

function About() {
  return (
    <div className="container mx-auto px-4 py-8">
      <header className="text-center mb-8">
        <h1 className="text-4xl font-display text-sol-orange-700 mb-4">
          🌮 Casa del Sol
        </h1>
        <p className="text-xl text-gray-600">
          About Us
        </p>
      </header>

      <nav className="flex justify-center space-x-6 mb-8">
        <Link 
          to="/" 
          className="px-4 py-2 bg-gray-200 text-gray-700 rounded hover:bg-gray-300 transition-colors"
        >
          Home
        </Link>
        <Link 
          to="/menu" 
          className="px-4 py-2 bg-gray-200 text-gray-700 rounded hover:bg-gray-300 transition-colors"
        >
          Menu
        </Link>
        <Link 
          to="/about" 
          className="px-4 py-2 bg-sol-orange-500 text-white rounded hover:bg-sol-orange-600 transition-colors"
        >
          About
        </Link>
        <Link 
          to="/contact" 
          className="px-4 py-2 bg-gray-200 text-gray-700 rounded hover:bg-gray-300 transition-colors"
        >
          Contact
        </Link>
      </nav>

      <main className="text-center">
        <div className="max-w-2xl mx-auto">
          <h2 className="text-2xl font-display text-gray-800 mb-4">
            Our Story ☀️
          </h2>
          <div className="bg-sol-orange-50 p-6 rounded-lg text-left">
            <p className="text-gray-600 mb-4">
              <strong>Casa del Sol</strong> brings the authentic flavors of Mexico to your table. 
              Our name, meaning "House of the Sun," reflects our commitment to warmth, 
              hospitality, and the vibrant spirit of Mexican cuisine.
            </p>
            <p className="text-gray-600 mb-4">
              Founded with a passion for traditional recipes passed down through generations, 
              we use only the freshest ingredients and time-honored cooking techniques to 
              create dishes that transport you to the heart of Mexico.
            </p>
            <p className="text-gray-600">
              From our handmade tortillas to our signature salsas, every element on your 
              plate is crafted with love and respect for the culinary traditions that 
              inspire us.
            </p>
          </div>
        </div>
      </main>
    </div>
  )
}

export default About