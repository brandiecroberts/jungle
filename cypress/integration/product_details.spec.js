describe('', () => {
  beforeEach(() => {
    cy.visit('http://localhost:3000/');
  });

  it("There is products on the page", () => {
    cy.get(".products article").should("be.visible");
  });

  it("There is 12 products on the page", () => {
    cy.get(".products article").should("have.length", 12);
  });
  
  it("Should navigate to the products page when clicking on a product", () => {
    cy.get('img[alt]').first().click();
    cy.url().should('include', '/products/');
  });

});