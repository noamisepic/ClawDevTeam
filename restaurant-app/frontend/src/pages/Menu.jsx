import { Link } from 'react-router-dom'

function Menu() {
  return (
    <div className="container mx-auto px-4 py-8">
      <header className="text-center mb-8">
        <h1 className="text-4xl font-display text-sol-orange-700 mb-4">
          🌮 Casa del Sol
        </h1>
        <p className="text-xl text-gray-600">
          Menu
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
          className="px-4 py-2 bg-sol-orange-500 text-white rounded hover:bg-sol-orange-600 transition-colors"
        >
          Menu
        </Link>
        <Link 
          to="/about" 
          className="px-4 py-2 bg-gray-200 text-gray-700 rounded hover:bg-gray-300 transition-colors"
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
            Our Menu 📜
          </h2>
          <div className="bg-sol-orange-50 p-6 rounded-lg">
            <p className="text-gray-600 mb-4">
              Menu items will be loaded from the backend database once Jordan completes the API setup.
            </p>
            <p className="text-sm text-gray-500">
              Coming soon: Appetizers • Mains • Desserts • Beverages
            </p>
          </div>
        </div>
      </main>
    </div>
  )
}

export default Menu