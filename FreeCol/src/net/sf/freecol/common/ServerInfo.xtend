/** 
 * Copyright (C) 2002-2015   The FreeCol Team
 * This file is part of FreeCol.
 * FreeCol is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 2 of the License, or
 * (at your option) any later version.
 * FreeCol is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * You should have received a copy of the GNU General Public License
 * along with FreeCol.  If not, see <http://www.gnu.org/licenses/>.
 */
package net.sf.freecol.common

import net.sf.freecol.FreeCol
import org.w3c.dom.Document
import org.w3c.dom.Element

/** 
 * Contains information about a single server.  This information is
 * normally retrieved from a meta-server.
 * @see net.sf.freecol.metaserver
 */
class ServerInfo {
	String name
	String address
	int port
	int currentlyPlaying
	int slotsAvailable
	boolean isGameStarted
	String version
	int gameState

	/** 
	 * Empty constructor that can be used by subclasses.
	 */
	protected new() {
	}

	/** 
	 * Creates a new object with the given information.
	 * @param name The name of the server.
	 * @param address The IP-address of the server.
	 * @param port The port number in which clients may connect.
	 * @param slotsAvailable Number of players that may conncet.
	 * @param currentlyPlaying Number of players that are currently connected.
	 * @param isGameStarted <i>true</i> if the game has started.
	 * @param version The version of the server.
	 * @param gameState The current state of the game.
	 */
	new(String name, String address, int port, int slotsAvailable, int currentlyPlaying, boolean isGameStarted,
		String version, int gameState) {
		update(name, address, port, slotsAvailable, currentlyPlaying, isGameStarted, version, gameState)
	}

	/** 
	 * Creates an object from the given <code>Element</code>.
	 * @param element The XML DOM Element containing the information that will be
	 * used for the new object.
	 */
	new(Element element) {
		readFromXMLElement(element)
	}

	/** 
	 * Updates the object with the given information.
	 * @param name The name of the server.
	 * @param address The IP-address of the server.
	 * @param port The port number in which clients may connect.
	 * @param slotsAvailable Number of players that may conncet.
	 * @param currentlyPlaying Number of players that are currently connected.
	 * @param isGameStarted <i>true</i> if the game has started.
	 * @param version The version of the server.
	 * @param gameState The current state of the game.
	 */
	def void update(String name, String address, int port, int slotsAvailable, int currentlyPlaying,
		boolean isGameStarted, String version, int gameState) {
		this.name = name
		this.address = address
		this.port = port
		this.slotsAvailable = slotsAvailable
		this.currentlyPlaying = currentlyPlaying
		this.isGameStarted = isGameStarted
		this.version = version
		this.gameState = gameState
	}

	/** 
	 * Update the server info from an element.
	 * @param element The <code>Element</code> to update from.
	 */
	def final void update(Element element) {
		update(element.getAttribute("name"), element.getAttribute("address"),
			Integer.parseInt(element.getAttribute("port")), Integer.parseInt(element.getAttribute("slotsAvailable")),
			Integer.parseInt(element.getAttribute("currentlyPlaying")),
			Boolean.parseBoolean(element.getAttribute("slotsAvailable")), element.getAttribute("version"),
			Integer.parseInt(element.getAttribute("gameState")))
	}

	/** 
	 * Returns the name of the server that is beeing represented 
	 * by this object.
	 * @return The name.
	 */
	def String getName() {
		return name
	}

	/** 
	 * Returns the IP-address.
	 * @return The IP-address of the server.
	 */
	def String getAddress() {
		return address
	}

	/** 
	 * Returns the port in which clients may connect.
	 * @return The port.
	 */
	def int getPort() {
		return port
	}

	/** 
	 * Returns the number of currently active (connected and not dead) players.
	 * @return The number of players.
	 */
	def int getCurrentlyPlaying() {
		return currentlyPlaying
	}

	/** 
	 * Returns the number of players that may connect.
	 * @return The number of slots available on the server.
	 */
	def int getSlotsAvailable() {
		return slotsAvailable
	}

	/** 
	 * Returns the FreeCol version of the server.
	 * @return The version.
	 * @see FreeCol#getVersion
	 */
	def String getVersion() {
		return version
	}

	/** 
	 * Gets the current state of the game.
	 * @return The current state of the game.
	 * @see net.sf.freecol.server.FreeColServer#getGameState
	 */
	def int getGameState() {
		return gameState
	}

	/** 
	 * Creates an XML-representation of this object.
	 * @param document The document in which the element should be created.
	 * @return The XML DOM Element representing this object.
	 */
	def Element toXMLElement(Document document) {
		var Element element = document.createElement(getXMLElementTagName())
		element.setAttribute("name", name)
		element.setAttribute("address", address)
		element.setAttribute("port", Integer.toString(port))
		element.setAttribute("slotsAvailable", Integer.toString(slotsAvailable))
		element.setAttribute("currentlyPlaying", Integer.toString(currentlyPlaying))
		element.setAttribute("isGameStarted", Boolean.toString(isGameStarted))
		element.setAttribute("version", version)
		element.setAttribute("gameState", Integer.toString(gameState))
		return element
	}

	/** 
	 * Reads attributes from the given element.
	 * @param element The XML DOM Element containing information that
	 * should be read by this object.
	 */
	def void readFromXMLElement(Element element) {
		update(element)
	}

	/** 
	 * Gets the tag name of the root element representing this object.
	 * @return "metaItem".
	 */
	def static String getXMLElementTagName() {
		return "serverInfo"
	}

	/** 
	 * Returns a <code>String</code> representation of this object for debugging purposes.
	 */
	override String toString() {
		return '''«name»(«address»:«port») «currentlyPlaying», «slotsAvailable», «isGameStarted», «version», «gameState»'''
	}
}
