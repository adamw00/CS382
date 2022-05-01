/*
 * PlaylistNode.h
 *
 *  Created on: Sep 14, 2021
 *      Author: adam woo
 *      I pledge my honor that I have abided by the Stevens Honor System.
 */

#ifndef PLAYLISTNODE_H_
#define PLAYLISTNODE_H_

typedef struct PlaylistNode{
	char uniqueID[50];
	char songName[50];
	char artistName[50];
	int songLength;
	PlaylistNode* nextNodePtr;
} PlaylistNode;

void SetPlaylistNode(PlaylistNode* thisNode, char idInit[], char songNameInit[], char artistNameInit[], int songLengthInit);
void PrintPlaylistNode();
PlaylistNode* GetNextPlaylistNode(PlaylistNode* thisNode);

#endif /* PLAYLISTNODE_H_ */
