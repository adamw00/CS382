/*
 * main.c
 *
 *  Created on: Sep 14, 2021
 *      Author: adam woo
 *      I pledge my honor that I have abided by the Stevens Honor System.
 */
#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include "PlaylistNode.h"

int main() {
	char playlistName[50];
	PlaylistNode head;
	char choice;

	printf("Enter playlist's title:\n");
	gets(playlistName);

	while(1) {
		PrintMenu(playlistName);
		while(1){
			printf("Choose an option:\n");
			choice = getchar();
			if (choice == 'a' || choice == 'r' || choice == 'o' || choice == 'q') {
				break;
			}
		}
		if (choice == 'q') {
			break;
		}
		head = ExecuteMenu(choice,playlistName,head);
	}
}

void PrintMenu(char pName[]) {
	printf("%s PLAYLIST MENU\n", pName);
	printf("a - Add song\n");
	printf("r - Remove song\n");
	printf("o - Output full playlist\n");
	printf("q - Quit\n");
}

PlaylistNode* ExecuteMenu(char choice, char pName[], PlaylistNode* head) {
	if (choice == 'a'){
		PlaylistNode *dummy = head;
		head->nextNodePtr = malloc(sizeof(PlaylistNode)); //fix this later

	} else if (choice == 'r') {
		PlaylistNode prev;
		PlaylistNode *tmp = head;
		char id[50];
		printf("Enter song's unique ID:\n");
		gets(id);
		if (!tmp->nextNodePtr && tmp->uniqueID == id) {
			head = tmp->nextNodePtr;
			free(tmp);
			return head;
		}
		while (tmp->nextNodePtr && tmp->uniqueID != id) {
			prev = tmp;
			tmp = tmp->nextNodePtr;
		}

		if (tmp == '\0') {
			return head;
		}

		prev->nextNodePtr = tmp->nextNodePtr;
		free(tmp);
		return head;
	} else if (choice == 'o') {
		PlaylistNode *dummy = head;
		int count = 0;
		if (head->uniqueID == '\0'){
			printf("Playlist is empty.\n");
			return head;
		}
		printf("%s - OUTPUT FULL PLAYLIST",pName);
		while (head->nextNodePtr) {
			count+=1;
			printf("\n%d.\n", count);
			printf("Unique ID: %d\n", head->uniqueID);
			printf("Song Name: %s\n", head->songName);
			printf("Artist Name: %s\n", head->artistName);
			printf("Song Length (in seconds): %d\n", head->songLength);
			head = head->nextNodePtr;
		}
		return dummy;
	}
}
