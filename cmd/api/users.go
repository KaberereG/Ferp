package main

import (
	"strconv"

	"ferp-go/internal/store"
	"net/http"

	"github.com/go-chi/chi/v5"
)

type postkey string

type CreateUserPayload struct {
	Username string `json:"username" validate:"required"`
	Email    string `json:"email" validate:"required"`
	Password int64  `json:"password" validate:"required"`
}

func (app *application) getUserHandler(w http.ResponseWriter, r *http.Request) {
	userID, err := strconv.ParseInt(chi.URLParam(r, "userID"), 10, 64)
	if err != nil {
		app.badRequestResponse(w, r, err)
		return
	}

	ctx := r.Context()
	user, err := app.store.Users.GetByID(ctx, userID)
	if err != nil {
		switch err {
		case store.ErrNotFound:
			app.badRequestResponse(w, r, err)
			return
		default:
			app.internalServerError(w, r, err)
			return
		}

	}

	if err := app.jsonResponse(w, http.StatusOK, user); err != nil {
		app.internalServerError(w, r, err)
	}

}

func (app *application) createUserHandler(w http.ResponseWriter, r *http.Request) {
	var payload CreateUserPayload

	if err := readJSON(w, r, &payload); err != nil {
		app.badRequestResponse(w, r, err)
		return
	}

	if err := Validate.Struct(payload); err != nil {
		app.badRequestResponse(w, r, err)
		return
	}

	user := &store.User{
		Username: payload.Username,
		Email:    payload.Email,
		Password: payload.Password,
	}
	ctx := r.Context()

	if err := app.store.Users.Create(ctx, user); err != nil {
		app.internalServerError(w, r, err)
		return
	}

	if err := app.jsonResponse(w, http.StatusCreated, user); err != nil {
		app.internalServerError(w, r, err)
		return
	}
}
