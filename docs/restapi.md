openapi: 3.0.0
info:
  title: "OnCalls.com v3.0 API"
  version: "1.0.0"
  description: "API for the OnCalls.com medical scheduling application, reflecting the existing database schema."
servers:
  - url: "/api"
    description: "Staging Server"

paths:
  /group/users:
    get:
      summary: "List all users in the authenticated user's group"
      description: "Retrieves a list of all users (from the 'passwords' table) for the group."
      responses:
        '200':
          description: "A list of users."
          content:
            application/json:
              schema:
                type: array
                items:
                  $ref: '#/components/schemas/User'

  /group/shifts:
    get:
      summary: "List all shifts for the group"
      description: "Retrieves a list of all shifts (from the 'groupcalls' table) for the group."
      responses:
        '200':
          description: "A list of shifts."
          content:
            application/json:
              schema:
                type: array
                items:
                  $ref: '#/components/schemas/Shift'

components:
  schemas:
    User:
      type: object
      properties:
        docid:
          type: integer
        Login:
          type: string
        Admin:
          type: boolean
        fname:
          type: string
        lname:
          type: string
    Shift:
      type: object
      properties:
        id:
          type: integer
        callabr:
          type: string
        callfull:
          type: string
        points:
          type: number